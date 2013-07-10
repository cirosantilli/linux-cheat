to use a library you may need:

- the compiled `.so` or `.a` 

- for c and c++, the header `.h` file(s).

    This allows your compiler to check at compile time that your are calling
    functions correctly (supposing of course that the `.h` files you include
    correspond to the actual library files)

    This is not needed in languages such as fortran (down point for fortran).

either those must be in you compiler find path
(different for headers and compiled files)
or you must explicitly add them to the path.

# dynamic vs static

dynamic libraries are compiled libraries
kept outside of the executable and are used at run time

they have `.so` extension on linux and `.dll` on windows

dynamic libraries are different from static libraries (`.o` and `.a`)
static libraries are put inside the executable at compile time

advantages and disadvantages of dynamic libraries over static libraries
are the usual tradeoffs of share vs embbed design choices

advantages:

- memory saving by keeping only a single version of the library

    static libraries mean one version per executable

    this makes it absolutelly essential to use dynamic libraries for very large libraries.

- if the library inner working get updated to be (faster, use less memory),

    but not the interface ( inputs, outputs, side effects)

    there is no need to recompile the executable to get the updates.

disadvantages:

- more complicated to use

- usage is os dependant

- slight load overhead

since the disadvantages are so minor, it is almost always better to use dynamic linking.

# search path

find where gcc search path for both `.a` and `.so`:

    gcc -print-search-dirs | grep '^libraries' | tr ':' $'\n'

# static

gets included in program

program gets larger

you don't have to worry about dependancies

    gcc -c a.c
    gcc -c b.c
    ar rcs a.a a.o b.o
    gcc a.a c.c

# dynamic

## loading vs linking

there are two methods of using dynamic libraries in linux

### linking

link to lib for entire program

simpler

### loading

explicitly load needed functions during program execution

## create so

*MUST* compile like this:

    gcc -c -fPIC a.c
    gcc -c -fPIC b.c
    gcc -shared a.o b.o -o libab.so

using `-fPIC` and `-shared`

## version numbering

standard: up to 3 numbers

yes, they come after the `.so`
otherwise possible ambiguity:
`liba.1.so` is version 1 of `liba` or simply `lib.a.1`?

to link to a given version:
use full basename linking with verison number.

linking takes care of version defaults:

- liba.so.1.1.1

    necessarily itself

- liba.so.1.1

    itself

    or a link to 1.1.1

    or a link to 1.1.2

    ...

- liba.so.1

    itself

    or a link to 1.1

    or a link to 1.2

    or a link to 1.1.2

    or a link to 1.2.1

    ...

- liba.so

    itself

    or a link to 1

    or a link to 2

    or a link to 1.1

    or a link to 1.2

    ...

rationale: if you underspecify the library you get by default the most recent

convention: change in first number means possible interface break

## compile executable that depends on an so

you must tell gcc which libs to use with the `-l` flag

the linker will check that the library is there
and that it contains the necessary definitions

also, the path information will be kept inside the executable.

how this information is represented is a part of the `.elf` format definition.

*remember*: when the program will run, it must be able to find that `.so`
again on the load path!

### what can be passed to -l

the name given to -l must be EITHER:

- stripped from `lib` and `.so` part

    Ex: `m`, for `libm.so`. *will not work for `libm.so.1` !!!!!

- colon + `:`full basename. Ex: `-l:libm.so.1`

you need to compile like this so gcc
can tell if all your functions are definied

### relative vs absolute

the path to the so gets stored inside the elf so that it can be found
when the program will load

link to library libm.so:

    gcc a.c -o a.out -lm
    gcc a.c -o a.out -l:libm.so

relative paths to the load path get stored in the elf file.

`readelf -d` shows that:

    readelf -d a.out

store the full path in the elf file:

    gcc a.c -o a.out -l:/full/path/to/libm.so

    readelf -d a.out

it must be in the load path

### append path to so search path

#### -L option

    gcc a.c -o a.out -L/full/path/to/ -lm
    gcc a.c -o a.out -L./rel/path/to/ -lm

#### LD_LIBRARY_PATH

    env LIBRARY_PATH=$LIBRARY_PATH:/path/to/ gcc a.c -o a.out -llib

*note*: `LIBRARY_PATH` is different from `LD_LIBRARY_PATH`!
`LIBRARY_PATH` is only used at compile time
while `LD_LIBRARY_PATH` is only used at compile time

## use so at runtime

after an executable has been compiled to use an so,
the so must be found at runtime

this is done by a program called the [interpreter][]

the interpreter will use the library path stored inside the elf
file that is being executed and will also search inside a search
path called load path

there is no need to use the load path if an absolute path
was stored in the executable, but this is not recommended
since it would not be portable

### best production method

    sudo mv liba.so /some/where/in/link/path
    sudo ldconfig
    ./a.elf

this suposes that when you compiled you used: `-lliba.so`

### environment variable

    env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/absolute/path/to/lib ./a.out
    ./a.elf

BAD:

    env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./rel/path/to/lib/from/cd ./a.out
    ./a.out

this only works if you are in the right dir
since relative path is take to current dir

`LD_LIBRARY_PATH` has nothing to do with `LIBRARY_PATH` path variable
which is used during compilation by gcc!
`LD_LIBRARY_PATH` is used during execution by the linker!

### load path

view library load path:

    cat /etc/ld.so.conf

remember: after modifying this file, you must update the load file [cache][]
or your changes will not be taken into effect

may also include other files by adding a line to that file:

    include /etc/ld.so.conf.d/*.conf

this is done by default on Ubuntu.

to take includes into consideration and print the actual search path, use ldconfig.
see [view load path]

so you also need to look inside included files for the libraries:

    cat /etc/ld.so.conf.d/*.conf

the following paths are hard codded in `ldconfig`:

- `/lib/`
- `/usr/lib/`

### view load path

print actual search path after resolving directives like `include`:

    ldconfig -v 2>/dev/null | grep -v $'^\t'

show directories that are scanned and libraries that are found
in each dir:

    ldconfig -v

print cache stored in `/etc/ld.so.cache` and `.d` includes.
does not show in which directory libraries are stored in,
only where they link to:

    ldconfig -p

#### hwcap

when using commands like `ldconfig -v`, you may see outputs like:

    /usr/lib/i386-linux-gnu/sse2: (hwcap: 0x0000000004000000)

`hwcap` stands for `hardware capacities`

if present, means that those libraries can only be used
if you hardware has the given capacities

here for example, as shown in the directory name,
this path is for libraries which depend on the sse2
extensions (a set of cpu instructions, not present
in older cpus)

what the flags mean is defined by x86 and somewhat standardized across vendors:

<http://en.wikipedia.org/wiki/CPUID#EAX.3D1:_Processor_Info_and_Feature_Bits>

TODO where ldconfig finds this info:

### cache

it would be very slow to search the path every time

therefore the linker keeps uses a cache at:

    cat /etc/ld.so.cache

it first looks for libs there,
and only then searches the path

you can generate `/etc/ld.so.cache` automatically
once you have your `ld.so.conf` with `ldconfig`

even if the linker finds the lib in the path,
it does not automatically add it to the cache
so you still have to run `ldconfig`

running ldconfig is a part of every package install/uninstall
if it conatins a lib

### ldd

List required shared libraries of an executable
and if they can be found.

Binutils package.

Is a convenient subset of `readelf -d`

    ldd a.elf

possible outputs:

- `Not a dynamic executable`
- `liba.1.so => /lib/liba.1.so`
- `liba.1.so => not found`

##### environment

you can also add to path with environment variables

don't rely on this method for production

    export LD_LIBRARY_PATH="/path/to/link"

### interpreter

program that loades shared libs for other programs

central part of the linux system

this program links to no shared libs!

    readelf a.elf | grep "Requesting program interpreter"

this gives an output such as:

    /lib/ld-linux.so.2

## override symbols in libraries

symbols in `a.o` will override symbols in linked libs

    echo "/path/to/my/a.o" | sudo tee -a /etc/ld.so.preload

useful mainly for emergency or tests

can also be achieved via:

    export LD_PRELOAD=

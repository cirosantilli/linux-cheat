# loading vs linking

## linking

link to lib for entire program

simpler

## loading

explicitly load needed functions during program execution

# create so

    gcc -c -fPIC a.c
    gcc -c -fPIC b.c
compile for .so
*MUST* compile like this
    gcc -shared a.o b.o -o libab.so

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

rationale: if you underspecify the library
you get by default the most recent

convention: change in first number means possible interface break

# compile with so

you must tell gcc which libs to use with the `-l` flag

## relative vs absolute

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

## what can be passed to 

the name given to -l must be EITHER:

- stripped from `lib` and `.so` part

    Ex: `m`, for `libm.so`. *will not work for `libm.so.1` !!!!!

- colon + `:`full basename. Ex: `-l:libm.so.1`

you need to compile like this so gcc
can tell if all your functions are definied

### append path to so search path

use the `-L` option

    gcc a.c -o a.out -L/full/path/to/ -lm
    gcc a.c -o a.out -L./rel/path/to/ -lm
    env LIBRARY_PATH=$LIBRARY_PATH:/path/to/ gcc a.c -o a.out -llib

     #
to view current path: <#library path>
     #
can also be done via LIBRARY_PATH variable
     #
HOWEVER, when the program will run,
you still need to add it to the load path!!!
     #
either on /etc/ld.so.cache or on the variable
`LD_LIBRARY_PATH` (which is completelly different from
`LIBRARY_PATH`, which can be used for compilation path,
but not for loading). see <#load path>.
     #
this is only good for compilation!!!

# execute

## best method

    sudo mv liba.so /some/where/in/link/path
    sudo ldconfig
optional but better, see <#search path>
    ./a.out

this suposes that when you compiled you used: `-lliba.so`

## LD_LIBRARY_PATH

this has nothing to do with LIBRARY_PATH path variable
which is used during compilation by gcc!

LD_LIBRARY_PATH is used during execution by the linker!

    env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/absolute/path/to/lib ./a.out
    ./a.out

BAD

    env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./rel/path/to/lib/from/cd ./a.out
    ./a.out

this only works if you are in the right dir
since relative path is take to current dir

required libs are stored in the ELF file at compilation
either as relative or absolute or absolute paths

next, the linker uses this information to find the library
during execution


you could build the exe, move the lib, and still link to it!

## ldd

list required shared libraries
and if they can be found

binutils package

is a convenient subset of `readelf -d`

    ldd a.out
#### cases:
##### Not a dynamic executable
##### liba.1.so => /lib/liba.1.so
##### liba.1.so => not found

## load path

    cat /etc/ld.so.conf
search path

may also include other files as for example:
`include /etc/ld.so.conf.d/*.conf`
in this case you want to:
    cat /etc/ld.so.conf.d/*.conf

the following are hard codded in `ldconfig`:
- /lib/
- /usr/lib/

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

#### ldconfig

    sudo ldconfig
###### search in dirs listed in `/etc/ld.so.conf`
and write found libs to `/etc/ld.so.cache``

    ldconfig -p
print cache stored in /etc/ld.so.cache and .d
does not show in which directory libraries are stored in
only where they link to

    ldconfig -v
show directories that are scanned and libraries that are found
in each dir

    ldconfig -v 2>/dev/null | grep -v $'^\t'
print search path

###### hwcap

/usr/lib/i386-linux-gnu/sse2: (hwcap: 0x0000000004000000)

stands for `hardware capacities`

if present, means that those libraries can only be used
if you hardware has the given capacities

here for example, as shown in the directory name,
this path is for libraries which depend on the sse2
extensions (a set of cpu instructions, not present
in older cpus)

####### where ldconfig finds this info:

####### what the flags mean:

<http://en.wikipedia.org/wiki/CPUID#EAX.3D1:_Processor_Info_and_Feature_Bits>

#### environment

you can also add to path with environment variables

don't rely on this method for production

    export LD_LIBRARY_PATH="/path/to/link"

# override symbols in libraries

    echo "/path/to/my/a.o" | sudo tee -a /etc/ld.so.preload
symbols in a.o will override symbols in liked libs

emergency/tests

    export LD_PRELOAD=
same effect

# interpreter

program that loades shared libs for other programs

this program links to no shared libs!

    readelf a.elf | grep "Requesting program interpreter"
    file -L /lib/ld-linux.so.2
ELF

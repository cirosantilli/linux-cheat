To use a library you may need:

-   the compiled `.so` or `.a`

-   for C and C++, the header `.h` file(s).

    This allows your compiler to check at compile time that your are calling functions correctly (supposing of course that the `.h` files you include correspond to the actual library files)

    This is not needed in languages such as Fortran. Down point for Fortran.

Either those must be in you compiler find path (different for headers and compiled files) or you must explicitly add them to the path.

#Dynamic vs static

Dynamic libraries are compiled libraries kept outside of the executable and are used at run time.

They have `.so` extension on Linux and `.dll` on windows

Dynamic libraries are different from static libraries (`.o` and `.a`) static libraries are put inside the executable at compile time.

Advantages and disadvantages of dynamic libraries over static libraries are the usual trade-offs of share vs embed design choices.

Advantages:

-   memory saving by keeping only a single version of the library

    Static libraries mean one version per executable

    This makes it absolutely essential to use dynamic libraries for very large libraries.

-   if the library inner working get updated to be (faster, use less memory),

    But not the interface ( inputs, outputs, side effects)

    There is no need to recompile the executable to get the updates.

Disadvantages:

- more complicated to use

- usage is OS dependant

- slight load overhead

Since the disadvantages are so minor, it is almost always better to use dynamic linking.

#Search path

Find where GCC search path for both `.a` and `.so`:

    gcc -print-search-dirs | grep '^libraries' | tr ':' $'\n'

#Static

Gets included inside the generated executable, making it larger.

You don't have to worry about dependencies.

    gcc -c a.c
    gcc -c b.c
    ar rcs a.a a.o b.o
    gcc a.a c.c

#Dynamic

##loading vs linking

There are two methods of using dynamic libraries in Linux: linking and loading.

###linking

Link to lib for entire program.

Simpler.

###loading

Explicitly load needed functions during program execution.

##create so

*Must* compile like this:

    gcc -c -fPIC a.c
    gcc -c -fPIC b.c
    gcc -shared a.o b.o -o libab.so

using `-fPIC` and `-shared`.

##version numbering

Standard: up to 3 numbers.

Yes, they come after the `.so` otherwise there would be ambiguity: `liba.1.so` is version 1 of `liba` or simply `lib.a.1`?

To link to a given version use full basename linking with version number.

Linking takes care of version defaults:

-   `liba.so.1.1.1`

    Necessarily itself.

-   `liba.so.1.1`

    Itself

    or a link to `1.1.1`

    or a link to `1.1.2`

    ...

-   `liba.so.1`

    Itself,

    or a link to `1.1`

    or a link to `1.2`

    or a link to `1.1.2`

    or a link to `1.2.1`

    ...

-   `liba.so`

    Itself,

    or a link to `1`

    or a link to `2`

    or a link to `1.1`

    or a link to `1.2`

    ...

Rationale: if you underspecify the library you get by default the most recent.

Convention: change in first number means possible interface break.

##Compile executable that depends on an so

You must tell `gcc` which libs to use with the `-l` flag.

The linker will check that the library is there and that it contains the necessary definitions.

Also, the path information will be kept inside the executable.

How this information is represented is a part of the `.elf` format definition.

*Remember*: when the program will run, it must be able to find that `.so` again on the load path!

###What can be passed to -l

The name given to `-l` must be either:

-   stripped from `lib` and `.so` part

    Ex: `m`, for `libm.so`. *will not work for `libm.so.1` !!!!!

-   colon + `:`full basename. Ex: `-l:libm.so.1`

You need to compile like this so GCC can tell if all your functions are defined.

###Relative vs absolute

The path to the so gets stored inside the elf so that it can be found when the program will load.

Link to library libm.so:

    gcc a.c -o a.out -lm
    gcc a.c -o a.out -l:libm.so

Relative paths to the load path get stored in the elf file.

`readelf -d` shows that:

    readelf -d a.out

Store the full path in the elf file:

    gcc a.c -o a.out -l:/full/path/to/libm.so

    readelf -d a.out

It must be in the load path.

###Append path to so header search path

####-L option

    gcc a.c -o a.out -L/full/path/to/ -lm
    gcc a.c -o a.out -L./rel/path/to/ -lm

####LD_LIBRARY_PATH

    env LIBRARY_PATH=$LIBRARY_PATH:/path/to/ gcc a.c -o a.out -llib

`LIBRARY_PATH` is different from `LD_LIBRARY_PATH`! `LIBRARY_PATH` is only used at compile time while `LD_LIBRARY_PATH` is only used at compile time.

##Use so at runtime

After an executable has been compiled to use an so, the so must be found at runtime.

This is done by a program called the [interpreter][].

The interpreter will use the library path stored inside the elf file that is being executed and will also search inside a search path called load path.

There is no need to use the load path if an absolute path was stored in the executable, but this is not recommended since it would not be portable.

###Best production method

    sudo mv liba.so /some/where/in/link/path
    sudo ldconfig
    ./a.elf

This supposes that when you compiled you used: `-lliba.so`.

###Environment variable

Good:

    env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/absolute/path/to/lib ./a.out
    ./a.elf

Bad:

    env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./rel/path/to/lib/from/cd ./a.out
    ./a.out

This only works if you are in the right dir since relative path is take to current dir.

`LD_LIBRARY_PATH` has nothing to do with `LIBRARY_PATH` path variable which is used during compilation by gcc! `LD_LIBRARY_PATH` is used during execution by the linker!

###Load path

View library load path:

    cat /etc/ld.so.conf

Remember: after modifying this file, you must update the load file cache
or your changes will not be taken into effect.

May also include other files by adding a line to that file:

    include /etc/ld.so.conf.d/*.conf

This is done by default on Ubuntu.

To take includes into consideration and print the actual search path, use `ldconfig`.

So you also need to look inside included files for the libraries:

    cat /etc/ld.so.conf.d/*.conf

The following paths are hard codded in `ldconfig`:

- `/lib/`
- `/usr/lib/`

###View load path

Print actual search path after resolving directives like `include`:

    ldconfig -v 2>/dev/null | grep -v $'^\t'

Show directories that are scanned and libraries that are found in each dir:

    ldconfig -v

Print cache stored in `/etc/ld.so.cache` and `.d` includes. does not show in which directory libraries are stored in, only where they link to:

    ldconfig -p

####hwcap

When using commands like `ldconfig -v`, you may see outputs like:

    /usr/lib/i386-linux-gnu/sse2: (hwcap: 0x0000000004000000)

`hwcap` stands for `hardware capacities`

If present, means that those libraries can only be used if you hardware has the given capacities.

Here for example, as shown in the directory name, this path is for libraries which depend on the sse2 extensions (a set of cpu instructions, not present in older cpus).

What the flags mean is defined by x86 and somewhat standardized across vendors:

<http://en.wikipedia.org/wiki/CPUID#EAX.3D1:_Processor_Info_and_Feature_Bits>

TODO where `ldconfig` finds this info:

###Cache

It would be very slow to search the path every time.

Therefore the linker keeps uses a cache at:

    cat /etc/ld.so.cache

It first looks for libs there, and only then searches the path.

You can generate `/etc/ld.so.cache` automatically once you have your `ld.so.conf` with `ldconfig`.

Even if the linker finds the lib in the path, it does not automatically add it to the cache so you still have to run `ldconfig`.

Running `ldconfig` is a part of every package install/uninstall if it contains a library.

###ldd

List required shared libraries of an executable and if they can be found.

`binutils` package.

Is a convenient subset of `readelf -d`

    ldd a.elf

Possible outputs:

- `Not a dynamic executable`
- `liba.1.so => /lib/liba.1.so`
- `liba.1.so => not found`

#####Environment

You can also add to path with environment variables.

Don't rely on this method for production.

    export LD_LIBRARY_PATH="/path/to/link"

###Interpreter

Program that loads shared libs for other programs.

Central part of the Linux system.

This program links to no shared libs!

    readelf a.elf | grep "Requesting program interpreter"

This gives an output such as:

    /lib/ld-linux.so.2

##Override symbols in libraries

Symbols in `a.o` will override symbols in linked libs.

    echo "/path/to/my/a.o" | sudo tee -a /etc/ld.so.preload

Useful mainly for emergency or tests.

Can also be achieved via:

    export LD_PRELOAD=

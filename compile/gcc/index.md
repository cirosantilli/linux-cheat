Gnu Compiler Collection: *not* c compiler

it is a large frontend to several subprograms such as `as`, `cpp`

it currently compiles: C, C++, Objective-C, Fortran, Java, Ada, and Go

# g++ vs gcc

g++: http://stackoverflow.com/questions/172587/what-is-the-difference-between-g-and-gcc

most important:

1) g++ treats both .c and .cpp files as c++, since .c is backwards compatible with c++, it works
2) g++ links to (but does not include) stdlib automatically, gcc does not!

# supported executable formats

## elf

linux

superseeds `.coff` which superseeds `a.out`

## mach-o

mac os

## pe

windows' current `.exe`s

# compilation steps

it is good to understand which steps are done towards compilation

only expanded macros with the c preprocessor:

    cpp a.c > a.i
    cpp b.c > b.i

different languages have different preprocessors

generate human readable assembly code:

    gcc -S a.i -o a.s
    gcc -S b.i -o b.s

specify format:

    gcc -masm=att -S a.c -o a.s
    gcc -masm=intel -S a.c -o a.s

default format: `att` which is historically what has larger gcc support

make machine code from assembly code:

    as -o a.o a.s
    as -o b.o b.s

this transforms human readable formats into binary object files

make machine code from c direcly:

    gcc -c a.c -o a.o
    gcc -c b.c -o b.o

all above steps in one

    ld -o ab.out a.o b.o

link object files into single executable

    gcc a.c b.c -o ab.out

does all above steps in one

if you use make, it is faster to genterate `.o`
and keep them, since if the source does not change,
make will not recompile the corresponding `.o`

# flags

## recommended compilation flags

always use this for production code if possible:

    gcc -std=c99 -pedantic-errors -Wall -03 -march=native a.c

this will make for portable, efficient code.

## Wall

enables all warnings:

    gcc -Wall

ALWAYS USE IT

enables all warnings, except `unused-variable`:

    gcc -Wall -Wno-unused-variable

## std

std specifies version os the language to be used

disables gcc extensions that conflict with c standrad

    gcc -std=c90
    gcc -std=c99
    gcc -std=1x

`c11` will be the next version and is still being developed at the time of writting

to allow gnu extensions:

    gcc -std=gnu90

this is necessary on projects that rely on the extensions, such as the linux kernel

## ansi

don't use this, use `std` instead

    gcc -ansi

implies the most recent `-std` which gnu considers is stable manner (not necessarily the latest)

changes with time, currently equals:

    gcc -std=c90

it is a bit confusing not to have a fixed version of the standard to comply to,
so just use std instead.

## pedantic

give warnings for code that does not comply with c1x standard:

            gcc -std=c1x -pedantic

this does not mean *FULL* complience, but greatly increases complience

there is currently no full complience check in `gcc`

give errors instead of warnings:

            gcc -std=c1x -pedantic-errors

## march

optimizes code to given cpu (arch is for archtecture)

may use instructions only available to given cpu

optimize for currrent compiling machine:

                gcc -march=native

strict 80386 instruction set. old, compatible, used on almost all desktops and laptops:

                gcc -march=i386

Arm v.7, used on mobiles today:

                gcc -march=armv7

## optimization

list possible optimizations for `-O`:

    gcc -Q -O --help=optimizers

the options:

- O0 : no speed optimization. This is the default
- O  : -O1 basic speed optimization
- O2 : more than O1
- O3 : more than O2
- Og : optimize for debugging
- Os : optimize for size
- Ofast : optimize for speed more than O3, *even if it breaks standards*

best general code optimization method:

    gcc -O3 a.c -o a.out

always use this for production code.

## M

don't compile, but generate a list of dependencies for the given source code
in a format suitable for a makefile rule, and output it to stdout

dependencies are basically the file itself and the required headers

for example, in `a.c`:

    #include <stdio.h>
    #include "a.h"

then:

    gcc -M a.c

outputs to stdout:

    a.c : /usr/include/stdio.h \
        a.h

to make this even more suitable for a makefile, you should suppress the
standard system files with `-MM`:

    gcc -MM a.c

giving:

    a.c : a.h

you can then use those on a makefile as:

    $(shell gcc -MM a.c)
        gcc a.c

# c preprocessor

does things like:

- fetching `#include` files
- evaluating and expanding `#define` and `#ifdef` macros

before the compilation

the executable is called `cpp`

gcc uses it implicitly

## define command line

defines can be made from command line arguments:

    gcc -DDEBUG -DLINELENGTH=80 -o c c.c

which is the same as adding

    #define DEBUG
    #define LINELENGTH 80

to top of file

## find include search path

    echo '' | cpp -v

look for sections:

- `include "..." search starts here`:
- `include <...> search starts here`:

## view preprocessed file

this is mostly useful for learing purposes only

using `cpp` directly:

	cpp c.c

this outputs the preprocessed file to stdout

using gcc as a frontend:

    gcc -E c.c

# cross compile

cross compiling means to compile a program for a different OS
or architecture than the one the compiler is running

gcc cannot cross compile for windows from linux (TODO check)

this can be done with mingw (TODO how)

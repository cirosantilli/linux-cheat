Gnu Compiler Collection: NOT c compiler

it is a large frontend to several subprograms such as `as`, `cpp`

it currently compiles: C, C++, Objective-C, Fortran, Java, Ada, and Go

# g++ vs gcc

g++: http://stackoverflow.com/questions/172587/what-is-the-difference-between-g-and-gcc

most important:

1) g++ treats both .c and .cpp files as c++, since .c is backwards compatible with c++, it works
2) g++ links to (but does not include) stdlib automatically, gcc does not!

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

enables all warnings:

    gcc -Wall

ALWAYS USE IT

enables all warnings, except `unused-variable:

    gcc -Wall -Wno-unused-variable

std specifies version os the language to be used

disable gcc extensions that conflict with c standrad

    gcc -std=c90
    gcc -std=c99
    gcc -std=1x

current most modern
                gcc -std=c11
not yet available
will be when implementation complete

                gcc -ansi
changes with time, currently equals `-std=c90`
don't use it

            gcc -std=c1x -pedantic
give warnings for code that does not comply with c1x standard
this does not mean *FULL* complience, but greatly increases complience
there is currently no full complience check in `gcc`
            gcc -std=c1x -pedantic-errors
give errors instead of warnings

###-march cputype

optimizes code to given cpu (arch is for archtecture)
may use instructions only available to given cpu

                gcc -march=native
optimize for currrent compiling machine
                gcc -march=i386
80386 instruction set. old, compatible, used on almost all desktops and laptops
                gcc -march=armv7
Arm v.7, used on mobiles today

###code optimization

    gcc -Q -O --help=optimizers

shows optimizations for -O

-O0 : no speed optimization. This is the default
-O : -O1 basic speed optimization
-O2 : more than O1
-O3 : more than O2
-Og : optimize for debugging
-Os : optimize for size
-Ofast : optimize for speed more than O3, *even if it breaks standards*

    gcc -O3 a.c -o a.out

compile with optimization

###summary

                    gcc -std=c99 -pedantic-errors -Wall -03 -march=native a.c
always use this for production code

###other

    gcc -std=gnu90

c90 + gcc extensions

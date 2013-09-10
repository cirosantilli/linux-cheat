Gnu Compiler Collection: *not* c compiler

it is a large frontend to several subprograms such as `as`, `cpp`

it currently compiles: C, C++, Objective-C, Fortran, Java, Ada, and Go

#g++ vs gcc

g++: http://stackoverflow.com/questions/172587/what-is-the-difference-between-g-and-gcc

most important:

1) g++ treats both .c and .cpp files as c++, since .c is backwards compatible with c++, it works
2) g++ links to (but does not include) stdlib automatically, gcc does not!

#supported executable formats

- elf (linux)
- mach-o (mac os)
- pe (windows)

and more.

#compilation steps

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

#flags

##recommended compilation flags

Good discussion: <http://stackoverflow.com/questions/154630/recommended-gcc-warning-options-for-c>

Always use this for production output code if possible:

    gcc -std=c99 -pedantic-errors -Wall -Wextra -03 -march=native -o a a.c

this will make for portable, efficient code.

For test code, ommit the `-03`, since that will make compilation faster.

##o

Output destination.

Default: `a.out`.

For stdout: `-o -`.

##Wall

Enables many useful warnings:

    gcc -Wall

Understanding each warning and being able to write warning free code
is a good way to improve language skills.

##Wextra

Enables even more useful warnings than wall.

    `gcc -Wextra`

##std

std specifies version os the language to be used

disables gcc extensions that conflict with c standrad

    gcc -std=c90
    gcc -std=c99
    gcc -std=1x

`c11` will be the next version and is still being developed at the time of writting

to allow gnu extensions:

    gcc -std=gnu90

this is necessary on projects that rely on the extensions, such as the linux kernel

##ansi

don't use this, use `std` instead

    gcc -ansi

implies the most recent `-std` which gnu considers is stable manner (not necessarily the latest)

changes with time, currently equals:

    gcc -std=c90

it is a bit confusing not to have a fixed version of the standard to comply to,
so just use std instead.

##pedantic

give warnings for code that does not comply with c1x standard:

            gcc -std=c1x -pedantic

this does not mean *FULL* complience, but greatly increases complience

there is currently no full complience check in `gcc`

give errors instead of warnings:

            gcc -std=c1x -pedantic-errors

##march

optimizes code to given cpu (arch is for archtecture)

may use instructions only available to given cpu

optimize for currrent compiling machine:

                gcc -march=native

strict 80386 instruction set. old, compatible, used on almost all desktops and laptops:

                gcc -march=i386

Arm v.7, used on mobiles today:

                gcc -march=armv7

##optimization

list possible optimizations for `-O`:

    gcc -Q -O --help=optimizers

the options:

- O0 : no speed optimization. This is the default
- O  : basic speed optimization. Same as `-O1`.
- O2 : more than O1
- O3 : more than O2
- Og : optimize for debugging
- Os : optimize for size
- Ofast : optimize for speed more than O3, *even if it breaks standards*

best general code optimization method:

    gcc -O3 a.c -o a.out

always use this for production code.

##debugging

Gcc has options that allow you to add debugging information to binary outputs.

This leads to larger output files, but the information can then be used by programs such as
gdb or objdump to help debug programs, or for educational purposes.

Add debug information to executable on compilation:

    gcc -ggdb3 a.c

options

- g:        generate debug info for gdb
- ggdb :    adds more info
- ggdb3 :   adds max info. default if 2 when ggdb is used.

##M

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

##assembly code

If you want to interpret assmebly code generated by `gcc`, the best combo is:

    gcc -fverbose-asm -S a.c

To get original line number / code from C code into asm comments, use either:

    gcc -c -fverbose-asm -Wa,-adhln a.c

or:

    gcc -ggdb3 -o a.o a.c
    objdump -S a.o

###-S

Generate assemby code:

    gcc -S a.c

generates gas assembly code to a new file called `a.S`.

##-fverbose-asm

Outputs comments on the generated assembly which say variable names are being operated on each statment:

    gcc -fverbose-asm -S a.c

Sample C input:

    i = 1;
    j = i;

ouptut without `-fverbose-asm`:

    movl $1, -64(%ebp)
    movl -64(%ebp), %eax
    movl %eax, -68(%ebp)

with `-fverbose-asm`:

    movl $1, -64(%ebp)   # ,i
    movl -64(%ebp), %eax #i, tmp123
    movl %eax, -68(%ebp) #tmp123, j

##-f options

What are the -f options?

##-Wa options

Same as `-Xassembler`.

Example:

    gcc -c -fverbose-asm -Wa,-adhln a.c


##-Xassembler

Pass options directly to the `as` assembler.

Example:

    gcc -c -fverbose-asm -Xassembler -adhln a.c

#preprocessor

The executable is called `cpp`.

gcc uses it as a backend.

##-D

Make preprocessor defines command line.

Defines can be made from command line arguments:

    gcc -DDEBUG -DLINELENGTH=80 -o c c.c

which is the same as adding

    #define DEBUG
    #define LINELENGTH 80

to top of file.

##find include search path

    echo '' | cpp -v

Look at sections:

- `include "..." search starts here`:
- `include <...> search starts here`:

###-I

Append to the include search path:

    gcc -I/new/include/location/ a.c

##view preprocessed file

this is mostly useful for learing purposes only

using `cpp` directly:

	cpp c.c

outputs the preprocessed file to stdout

Using gcc as a frontend:

    gcc -E c.c

#cross compile

cross compiling means to compile a program for a different OS
or architecture than the one the compiler is running

gcc cannot cross compile for windows from linux (TODO check)

this can be done with mingw (TODO how)

#infamous error messages

Error messages that are difficult to interpret for noobs:

- struct has incomplete type = struct undefined. You forgot to include some header.

#generated assembly

This contains information that help to understand the assembly code generated by gcc,
for example via the `-S` flag.

The generated assembly code is in the `gas` format.
`gas` specific features shall not be explained here.

##label name conventions

- .L*: local labels to current file
- .LFB*: function begin
- .LFE*: function end
- .LC*: function end
- .LCFI:
- .LBB:
- .LBE:

#sources

- <http://www.ibm.com/developerworks/library/l-gcc-hacks/>

    Good selection of useful features.

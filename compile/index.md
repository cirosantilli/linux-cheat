#binutils
#binutils

Gnu set of utilities to compile and view and modify compiled code.

Official site: <http://sourceware.org/binutils/>.

As stated there, the two main utilities are `ld`, the gnu liner, and `as` the gnu assembler.

##ar

Create `.a` archives from `.o` files:

    ar rcs a.a a.o b.o

TODO this is deprecated in POSIX 7, why?

##nm

Get symbol table for object files:

    nm a.o

##readelf

Get information stored inside executable files in a human readable way.

Show symtable (defined stuff) of elf .o or .so:

    readelf -s liba.so

Show dependencies of an executable (symbols and shared libs):

    readelf -d a.out

TODO ?:

    readelf --relocs a.o

##elfedit

TODO

##objdump

See memory structure of executable:

    objdump --disassemble a.o
    objdump -h a.o

##size

Shows size of each memory part of a executable:

    gcc -c a.c
    gcc a.o
    size a.out a.o

- text : instructions
- data : init and uinit data
- dec and hex : size of executable in dec and hex

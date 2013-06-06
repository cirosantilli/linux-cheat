gnu set of utilities to compile and view and modify compiled code

official site: <http://sourceware.org/binutils/>

as stated there, the two main utilities are `ld`, the gnu liner, and `as` the gnu assembler.

# ar

create .a archives from .o files:

    ar rcs a.a a.o b.o

# nm

symbol table for object files

    nm a.o

# readelf

gets stored inside executable files in a human readable way

show symtable (defined stuff) of elf .o or .so:

    readelf -s liba.so

show dependencies of an executable (symbols and shared libs):

    readelf -d a.out

TODO ?:

    readelf --relocs a.o

# elfedit

TODO

# objdump

see memory structure of executable:

    objdump --disassemble a.o
    objdump -h a.o

# size

shows size of each memory part of a executable:

    gcc -c a.c
    gcc a.o
    size a.out a.o

- text : instructions
- data : init and uinit data
- dec and hex : size of executable in dec and hex

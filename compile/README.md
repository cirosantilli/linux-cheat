# Compile

- information related to executables such as formats (ex: elf) and dynamic linking
- tools for compiling languages (C, C++, Fortran, etc.) into executables, such as GCC
- tools for examining executable files

## Formats

There are different types of executable and object files.

### ELF

Defined in the LSB.

Supersedes `.coff` which supersedes `a.out`.

Specifies format for both object files (`.o`), shared object files (`.so`) and executable files.

Its structure can be examined in a human readable way via `readelf` and `objdump`.

### mach-o

MAC OS.

### pe

Windows current `.exe` as of 2013.

## binutils

Gnu set of utilities to compile and view and modify compiled code.

Official site: <http://sourceware.org/binutils/>.

As stated there, the two main utilities are `ld`, the gnu liner, and `as` the gnu assembler.

### ar

Create `.a` archives from `.o` files:

    ar rcs a.a a.o b.o

TODO this is deprecated in POSIX 7, why?

### nm

Get symbol table for object files:

    nm a.o

### readelf

Get information stored inside executable files in a human readable way.

See all information:

    readelf -a a.out

TODO understand all the information, and therefore the entire elf format.

To show only specific informations:

- `-s`: symtable (defined stuff) of elf, `.o` or `.so`
- `-d`: dependencies of an executable (symbols and shared libs)

### elfedit

TODO

### objdump

See assembler instructions of object file or executable:

    objdump -d a.o

Intermingle original C code with disassembly more or less where they coincide:

    gcc -ggdb3 -o a.o a.c
    objdump -S a.o

Binary files must be compiled with debugging information.

### size

Shows size of each memory part of a executable:

    gcc -c a.c
    gcc a.o
    size a.out a.o

- text:            instructions
- data:            init and uinit data
- `dec` and `hex`: size of executable in decimal and hexadecimal

#!/usr/bin/env bash

# Build binutils from source and test it out. Tested on Ubuntu 18.04.
# https://stackoverflow.com/questions/4252012/how-to-install-and-use-gas-gnu-compiler-on-linux/52928530#52928530
# https://askubuntu.com/questions/881656/how-to-install-gnu-assembler/1086089#1086089

d=binutils.tmp
rm -rf "$d"
mkdir "$d"
cd "$d"

set -eux

# Build.
sudo apt-get build-dep binutils
git clone git://sourceware.org/git/binutils-gdb.git
cd binutils-gdb
git checkout binutils-2_31
./configure --target x86_64-elf --prefix "$(pwd)/install"
make -j `nproc`
make install

# Test it out.
cat <<'EOF' > hello.S
.data
    s:
        .ascii "hello world\n"
        len = . - s
.text
    .global _start
    _start:
        mov $4, %eax
        mov $1, %ebx
        mov $s, %ecx
        mov $len, %edx
        int $0x80
        mov $1, %eax
        mov $0, %ebx
        int $0x80
EOF
./install/bin/x86_64-elf-as -o hello.o hello.S
./install/bin/x86_64-elf-ld -o hello hello.o
./hello

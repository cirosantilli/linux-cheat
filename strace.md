# strace

Get a list of system calls made by a given program.

## Assembly hello world

For a minimal IA-32 NASM hello world:

    section .data
        hello_world db "Hello world!", 10
        hello_world_len  equ $ - hello_world
    section .text
        global _start
        _start:
            mov eax, 4
            mov ebx, 1
            mov ecx, hello_world
            mov edx, hello_world_len
            int 80h

            mov eax, 1
            mov ebx, 0
            int 0x80

compiled and run with:

    nasm -felf32 -o hello_world.out hello_world.asm
    ./hello_world.out

we get:

    execve("./hello_world.out", ["./hello_world.out"], [/* 138 vars */]) = 0
    [ Process PID=18166 runs in 32 bit mode. ]
    write(1, "Hello world!\n", 13Hello world!
    )          = 13
    _exit(0)                                = ?
    +++ exited with 0 +++

## C hello world

For a minimal C hello world:

    #include <stdio.h>

    int main() {
        puts("Hello world C");
        return 0;
    }

compiled and run with:

    gcc -std=c89 -o hello_world.out hello_world.c
    ./hello_world.out

we get:

    execve("./hello_world.out", ["./hello_world.out"], [/* 138 vars */]) = 0
    brk(0)                                  = 0x981000
    access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
    mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4ed9997000
    access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
    open("tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
    open("tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
    open("x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
    open("libc.so.6", O_RDONLY|O_CLOEXEC)   = -1 ENOENT (No such file or directory)
    open("/usr/local/lib/tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
    stat("/usr/local/lib/tls/x86_64", 0x7fff5f3c8110) = -1 ENOENT (No such file or directory)
    open("/usr/local/lib/tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
    stat("/usr/local/lib/tls", 0x7fff5f3c8110) = -1 ENOENT (No such file or directory)
    open("/usr/local/lib/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
    stat("/usr/local/lib/x86_64", 0x7fff5f3c8110) = -1 ENOENT (No such file or directory)
    open("/usr/local/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
    stat("/usr/local/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
    open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 4
    fstat(4, {st_mode=S_IFREG|0644, st_size=167354, ...}) = 0
    mmap(NULL, 167354, PROT_READ, MAP_PRIVATE, 4, 0) = 0x7f4ed996e000
    close(4)                                = 0
    access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
    open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 4
    read(4, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320\37\2\0\0\0\0\0"..., 832) = 832
    fstat(4, {st_mode=S_IFREG|0755, st_size=1840928, ...}) = 0
    mmap(NULL, 3949248, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4, 0) = 0x7f4ed93b2000
    mprotect(0x7f4ed956d000, 2093056, PROT_NONE) = 0
    mmap(0x7f4ed976c000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x1ba000) = 0x7f4ed976c000
    mmap(0x7f4ed9772000, 17088, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f4ed9772000
    close(4)                                = 0
    mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4ed996d000
    mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4ed996b000
    arch_prctl(ARCH_SET_FS, 0x7f4ed996b740) = 0
    mprotect(0x7f4ed976c000, 16384, PROT_READ) = 0
    mprotect(0x600000, 4096, PROT_READ)     = 0
    mprotect(0x7f4ed9999000, 4096, PROT_READ) = 0
    munmap(0x7f4ed996e000, 167354)          = 0
    fstat(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
    mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4ed9996000
    write(1, "Hello world C\n", 14Hello world C
    )         = 14
    exit_group(0)                           = ?
    +++ exited with 0 +++

Wow, boilerplate! Just a few more calls than with the raw assembly :-)

If we remove the `puts()`, we see that the only commands it added were:

    fstat(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
    mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4ed9996000
    write(1, "Hello world C\n", 14Hello world C
    )         = 14

TODO understand. Would be cool if we 

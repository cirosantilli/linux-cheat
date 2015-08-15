# strace

Get a list of system calls made by a given program.

Most useful command:

    sudo strace -f -s999 -v program.out

Also consider `ltrace` to trace library calls.

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

Wow, boilerplate! Just a "few" more calls than with the raw assembly :-)

If we remove the `puts()`, we see that the only commands it added were:

    fstat(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
    mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4ed9996000
    write(1, "Hello world C\n", 14Hello world C
    )         = 14

## f

Monitor forked processes.

Great if you program calls other processes, which is usually done with a fork exec sequence.

Without `-f`, we stop seeing at the `fork` call, and cannot see what `exec` is being called with which is what we want.

Sample application: who is `gcc` calling `cc1` exactly?

We can run:

    strace -f gcc -S main.c |& less

Grepping for `cc1`, we see the lines:

    access("/usr/local/lib/gcc/x86_64-unknown-linux-gnu/5.1.0/", X_OK) = 0
    stat("/usr/local/libexec/gcc/x86_64-unknown-linux-gnu/5.1.0/cc1", {st_mode=S_IFREG|0755, st_size=135942122, ...}) = 0
    access("/usr/local/libexec/gcc/x86_64-unknown-linux-gnu/5.1.0/cc1", X_OK) = 0
    vfork(Process 6312 attached
    <unfinished ...>
    [pid  6312] execve("/usr/local/libexec/gcc/x86_64-unknown-linux-gnu/5.1.0/cc1", ["/usr/local/libexec/gcc/x86_64-un"..., "-quiet", "-imultiarch", "x86_64-linux-gnu", "hello_world.c", "-quiet", "-dumpbase", "hello_world.c", "-mtune=generic", "-march=x86-64", "-auxbase", "hello_world", "-o", "hello_world.s"], [/* 140 vars */] <unfinished ...>

`[/* 140 vars */]` stands for environment variables, which was omitted because it would be too large. This abbreviation can be prevented with `-s999 -v`.

## v

## s

Don't hide details of some system calls which would normally show `[/* 140 vars */]`.

You may also need `-s999` to see everything, otherwise the maximum line limit might get hit.

## Print addresses of string arguments

<http://stackoverflow.com/questions/21819011/how-can-i-make-strace-to-print-addresses-instead-of-strings>

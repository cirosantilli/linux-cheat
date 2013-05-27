/*
how to make a system call from c

# syscall function

to get a list of system calls:

    man 2 syscalls

to get doc on each system call:

    man 2 <syscall>

for example:

    man 2 write

# unistd wrapper

this is cheating, but mainly does what we want

many system calls already have c wrappers inside `unistd.h`

altough this file defines posix functions, not specific linux system calls
many of the posix functions are very close to the actual system calls,
and all that the unistd version does is to wrap them for c.

newer system calls may not be directly available inside `unistd.h`
and some processing may happen between the wrapper and the actual system call

# _syscall macro

deprecated method to do direct system calls

*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define _GNU_SOURCE
#include <sys/syscall.h>    /* for syscall.h. needs `_GNU_SOURCE`. */
#include <sys/types.h>      /* for SYS_<name> */
#include <asm/unistd.h>     /* for __NR_<number> */

int main(int argc, char** argv)
{
    char s[] = "ab\ncd";
    /* TODO: what is the usage difference between `asm/unistd.h __NR_X` and `sys/types SYS_NAME`? */
    syscall( SYS_write, 1, s, 3 );
    syscall( __NR_write, 1, s, 3 );
    return EXIT_SUCCESS;
}

/*
how to make a system call from c

# get info on system calls

to get a list of system calls:

    man 2 syscalls

to get doc on each system call:

    man 2 <syscall>

for example:

    man 2 write

# syscall

function used to make direct system calls from c

takes the syscall number followed by a variable number of arguments:

    syscall( number, arg1, arg2, ...)

where the arguments are the arguments of the system call

don't use bare system call numbers since those vary between architectures:

most system calls are defined on most architectures and have names which map
to the actual number, depending on the architecture. This is done with the
`__NR_<NAME>` constants in `asm/unistd.h` or SYS_<NAME> in `sys/types`

## __NR_ macros

are defined in the linux kernel directly

## SYS_ macros

are defined in terms of `__NR_` for compatibility

TODO: what is the difference between `asm/unistd.h __NR_X` and `sys/types SYS_NAME`? which is better in which situtaions?

# wrappers

instead of using system calls, consider using wrappers:

- ansi libc
- posix as in unistd

many of those wrappers are very thin and don't do much more than the system call itself

this is why so many wrapper functions have very similar names and interfaces to the actual calls.

# _syscall macro

deprecated method to do direct system calls

*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define _GNU_SOURCE
#include <unistd.h>         /* for `syscall`. Needs `_GNU_SOURCE`, cannot have strict ansi ( implied by `-std=c99` or `-ansi`. See: `features.h` */
#include <sys/syscall.h>    /* adds both __NR_ and SYS_ syscall number macros. TODO what is the `_LIBC` cpp var? */
/* #include <asm/unistd.h>  // for __NR_<number>. Already included by `sys/syscall.h` */
/* #include <sys/types.h>   // for SYS_<name> */

int main( int argc, char** argv )
{

    char s[] = "ab\ncd";
    syscall( __NR_write, 1, s, 3 );
    syscall( SYS_write,  1, s, 3 );
    return EXIT_SUCCESS;
}

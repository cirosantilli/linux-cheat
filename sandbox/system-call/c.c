/*
how to make a system call from c

# _syscall

TODO

# unistd wrapper

this is cheating, but mainly does what we want

many system calls already have c wrappers inside `unistd.h`

altough this file defines posix functions, not specific linux system calls
many of the posix functions are very close to the actual system calls,
and all that the unistd version does is to wrap them for c.

newer system calls may not be directly available inside `unistd.h`
and some processing may happen between the wrapper and the actual system call
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>

#define __NR_write 3
_syscall3(ssize_t, write, int, fd, const void *, buf, size_t, count)
//      1 2        3      4    5   6             7    8       9

/*

#__NR_X

defines the number of inputs of the system call X

# _syscall

macro that gives direct access to system calls,

defined in unistd TODO isin't unistd general posix, and not unix specific?

signature:

#. number of inputs (0-6)
#. return type
#. name to be given on user space
#. type of first    input
#. name    first
#.         second
#.         second
#.         third
#.         third

*/

int main(int argc, char** argv)
{
    //#system calls

        //

    return EXIT_SUCCESS;
}

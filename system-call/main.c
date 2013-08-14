/*How to make a system call from c,
and main cheat on system calls that can be exemplified.

System calls that have very similar POSIX wrappers such as `getpid`
shall only be mentioned but not explained in detail.

#syscall

        man syscall

    Function used to make direct system calls from C.

    Takes the syscall number followed by a variable number of arguments:

        syscall( number, arg1, arg2, ...)

    This function is not a bare system call only on what concerns error handling:
    the same processing that is done for the POSIX library is done in case of error,
    with error returns always `-1` and `errno` being set accordingly.

    This function automatically puts RAM variables into registers before calling the system call,
    and gets the return value from `eax` into RAM.

    It is however an exact system call when there is no error situation. For example,
    syscall getpriority returns values between 0 and 39, while the POSIX version
    can always return negative values.

    where the arguments are the arguments of the system call

    Don't use bare system call numbers since those vary between architectures.
    In this way, if you use a syscall that is available to all archs your code is arch portable.

    Most system calls are defined on most architectures and have names which map
    to the actual number, depending on the architecture. This is done with the
    `__NR_XXX` constants in `asm/unistd.h` or SYS_<NAME> in `sys/types`

    TODO return value type is long int?

#__NR_XXX macros

    Are defined in the linux kernel directly.

#SYS_ macros

    are defined in terms of `__NR_` for compatibility

    TODO: what is the difference between `asm/unistd.h __NR_X` and `sys/types SYS_NAME`? which is better in which situtaions?

#_syscall macro

    Deprecated method to do direct system calls. Don't use it.

#wrappers

    instead of using system calls, consider using wrappers:

    - ansi libc
    - posix as in unistd

    many of those wrappers are very thin and don't do much more than the system call itself

    this is why so many wrapper functions have very similar names and interfaces to the actual calls.

#TODO

    TODO what is the `_LIBC` preprocessor var?

    TODO how to get the system call constants such as PRIO_PROCESS without going into POSIX libs?
        is this exactly how those are exposed? Or is there a way that does not require POSIX headers?
*/

/*
`_GNU_SOURCE` needs to enable the linux extensions.
It *must* come before includes so that the preprocessor can see it..
Cannot have strict ansi ( implied by `-std=c99` or `-ansi`. See: `features.h`.
*/
#define _GNU_SOURCE

#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include <unistd.h>             /* syscall */
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/syscall.h>        /* __NR_XXX, SYS_XXX*/
/* #include <asm/unistd.h>      // __NR_XXX. Already included by `sys/syscall.h` */
/* #include <sys/types.h>       // for SYS_<name> */

#include <linux/reboot.h>         /* LINUX_REBOOT_XXX, */

int main( int argc, char** argv )
{
    /*
    #write

        Write to an open file descriptor.

        1 and 2 are stdout and stderr.

            asmlinkage long sys_write(unsigned int fd, const char __user *buf,
                        size_t count);

        - fd: file descriptor to write to
        - buf: what to write in an array
        - count: number of bytes to write
    */
    {
        char s[] = "ab\ncd";
        syscall( __NR_write, 1, s, 3 );
        syscall( SYS_write,  1, s, 3 );
    }

    /*
    #getpid

        Same as POSIX getpid

    #getppid

        Same as POSIX getppid
    */
    {
        assert( syscall( __NR_getpid ) == getpid() );
        assert( syscall( __NR_getppid ) == getppid() );
    }

    /*
    #getpriority

        Returns nice value on the range 0 .. 39, unlike the `getpriority` POSIX function
        which returns values between -20 and 19.

        This is done so as to follow the usual convention
        that sytem calls should return negative values only in case of error.
    */
    {
        long int prio = syscall( __NR_getpriority, PRIO_PROCESS, 0 );
        printf( "getpriority = %ld\n", prio );
        assert( getpriority( PRIO_PROCESS, 0 ) + 20 == prio );
    }

    /*
    #reboot

        Reboots or enables/disables ctrl+alt+del reboot.

            man 2 reboot

        No POSIX wrapper

        The man is serious: power off and restart are immediate.
        Programs are killed immediately, so any on RAM changes that should me made are not made.

        Also as the man says filsystem writes are not synced by this call,
        so there may be data loss because of cached writes which were never made.

        This system call can only be done with elevated priviledges (sudo).

    #magic numbers

        The magic numbers are numbers chosen to a rare value (not 0, 1 or -1 for example!).

        Their purpose is so that developpers won't accidentally reboot the system when testing system calls in assembler
        if they get a single number wrong.

        Their actual values are the dates of Linus and his three daughters birthdays when vied in hexa:
        <http://stackoverflow.com/questions/4808748/magic-numbers-of-the-linux-reboot-system-call>

        TODO what the H are those magic numbers that must have fixed values?

        TODO how to shut the system down nicely, asking processes to terminate?
            Is it necessary to loop over pids via proc filesystem and send terminate signals explicitly?

        TODO restart2 message is printed where?

        TODO what is halt?

        TODO why CAD on did nothing (c-a-del still does nothing)? how do i get my cad key?

    #sync

        Same as POSIX wrapper.

    #fsync

        Same as POSIX wrapper.
    */
    if ( 0 )
    {
        if ( syscall( __NR_sync ) != 0 ) {
            perror( "sync" );
        }

        if (
            syscall(
                __NR_reboot,
                LINUX_REBOOT_MAGIC1,
                LINUX_REBOOT_MAGIC2,
                LINUX_REBOOT_CMD_POWER_OFF,     NULL
                //LINUX_REBOOT_CMD_RESTART,     NULL
                //LINUX_REBOOT_CMD_RESTART2,    "BYE BYE"
                //LINUX_REBOOT_CMD_HALT,        NULL
                //LINUX_REBOOT_CMD_CAD_OFF,     NULL
                //LINUX_REBOOT_CMD_CAD_ON,      NULL
            )
            != 0
        ) {
            perror( "reboot" );
        }

    }

    /*
    #brk

        Sources:

        - man brk
        - <http://stackoverflow.com/questions/6988487/what-does-brk-system-call-do>

        Set data segment to given pointer.

        One of the ways in which malloc may be implemented by libc under linux.
        The other option is mmap.

        If this method is used exclusively, all malloc memory goes into a single segment,
        and it is up to the library to ensure that pointers by malloc do not overlap with
        other pointers.

        Beware that the glibc `brk()` does some error checking on top of the system call.

        Return value:

        - success: new location
        - failure: old location

        Error checking is done by checking that the new location moved relative to the old one.

        Heaps grow up.

    #sbrk

        Non POSIX library level only, not a system call, so it shall not be discussed here.
        Implemented with the brk system call.

        More convenient than `brk`.
    */
    {
        //TODO0 confirm all of this. Hard to find docs!

        unsigned long p, old_p;
        char *cp;

        //allocation is sure to fail and return current address
        //TODO0 is this correct? is there another way to get the end of the data?
        p = syscall( __NR_brk, NULL );
        printf( "brk = %lu\n", p );

        old_p = p;

        //allocate memory
        p = syscall( __NR_brk, p + 1 );

        //system call did not work
        if ( p < old_p ) {
            assert( false );
        }

        //check that the alloation works
        p = syscall( __NR_brk, NULL );
        assert( p == old_p + 1 );

        //use newly allocated memory
        cp = (char*)p;
        *cp = 1;

        //deallocate
        p = syscall( __NR_brk, old_p );
        if ( p > old_p ) {
            assert( false );
        }
    }

    /*
    #mmap
    */
    {
    }

    /*
    #exit

        Same as ASCII exit().
    */
    {
        syscall( __NR_exit, EXIT_SUCCESS );
    }
}

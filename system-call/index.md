This discusses system calls from a userland point of view.
Kernel internals of system calls are not discussed here.

Tell your OS to do things which user space program can't do directly such as:

- write to stdout, stderr, files
- exit a program
- reboot your computer
- file io
- access devices
- process / threading threading management

All of those operations are ultra OS dependant,
so when possible one should use portable wrappers
libracies like ansi libc or the posix headers

It is highly recommended that you also understand
how to make system calls directly from assembler
to really understand them since they have a primary
assembly interface.

It is also possible to call them from c code via certain macros.

System call inerfaces have to be very stable

#sources

- <http://syscalls.kernelgrok.com/>

    full linux syscal list

    links to the c manpages

    register args mnemonic

    links to online source code

- <http://www.lxhp.in-berlin.de/lhpsysc0.html>

    contains actual binary values of constants so you can make he calls from assembler

#linux

System calls available on one architechture may differ from those available on another architechture.

Most of the more commonly used ones are available on all architectures.

There are a bit more than 350 system calls available on all architecture, although individual
architectures can have many more. For example `alpha` has 505 syscalls as of 3.10-rc5.

Each system call gets a number in order of addition to the kernel:
this is called *syscall number*

This number can never be changed, but system calls may be declared deprecated.

To make any of the system calls, one must use the instruction `int $0x80`

`%eax` holds the syscall number

`%ebx`, `%ecx`, `%edx`, `%esx`, `%edi` are the params

#return value

The return value of the system call is put into eax when the system call is finished.

That is the only way for the sytem call to communiate directly with the calling process:
errno is TODO.

##errors

System calls can fail for much more reasons than is the case with userspace function,
since the kernel has to be careful and prevent processes from messing up the system.

In case of failure the program does not crash and no messages are printed:
it is up to the programmer to check that the syscall succeeded via its return value

By convention:

- most sytem calls return 0 on sucess, -1 on failure.

    In those cases, the main goal is not getting the actual return of the sytem call,
    but doing some side effect with it.

- some system calls can return positive integers in case of success,
    and -1 means failure.

    For example `write` returns the number of bytes writen if successful.

    Since this can never be negative, `-1` is used for errors.

- some system calls are always sucessful.

    This is the case for `getpid`, since all processes must have a PID,
    and any process has the prigiledge to view its own PID.

- getpriority is a special case, since for historical reasons the nice or a process
    is represented between -20 and 19.

    The solution is that the system call is simply shifted from 0 to 39.

    This is possible because the range of nice is small.

    Wrapper libraries such as POSIX may then convert this to the nice value between -20 and 19.

- a few system alls can return truly any positive or negative integers.

    This is the case for ptrace.

    In those cases, the sytem call returns the value via a pointer to a data.

    Then, on a higher level, glibc does:

            res = sys_ptrace(request, pid, addr, &data);
            if (res >= 0) {
                    errno = 0;
                    res = data;
            }
            return res;

    so that a user program has to do:

            errno = 0;
            res = ptrace(PTRACE_PEEKDATA, pid, addr, NULL);
            if (res == -1 && errno != 0)
                    /* error */

##errno

errno is an ANSI C and POSIX library level concept that does not exist on the system call level,

Itattempts to expose a simpler interface to user programs,
always returning `-1` on errors and using `errno` to identify the error.

System calls return only a single register value, and it is up to the syscall wrappers to tranform
that value into a proper return value and set `errno`.

Beaware that the `syscall` macro, while very low level syscall wrapper,
still does return value and errno setting manipulations just in a similar way to the POSIX error handling.

#get info on linux system calls

This describes methods on how to get information on system calls without reading through the actual source code.

Note however that all of those methods have certain limits, and there might be no actual alternative to
getting your hands dirty and reading the source.

Details on how to search the kernel source code for information on system calls shall not be described
here but inside a kernel internals cheat, since such a discussion overlaps too much with how system calls work internally.

TODO where are the descriptions of what a system call does in official docs (in the kernel tree for ideally?)
    Bad / missing docs as for the rest of the API? Is man-pages official?

TODO how to get a list of syscalls available on all architectures without grepping/processing kernel code?

##posix

Linux is highly POSIX compatible, which means that many of its system calls exist to
implement POSIX C library functions.

Often those functions have very similar names and arguments, and the POSIX descriptions are really good,
which makes this a good way to learn what syscalls do.

POSIX is portable so in learning it you also learn an interface which works on many other systems.

POSIX functions are more basic than those which are not in POSIX but on the Linux API,
so it is a good idea to start with them.

##man pages

TODO is the `man-pages` project official?

The man pages project documents portable glibc C interfaces to system calls.

This inclues many POSIX C library functions, plus LInux extensions
which glibc makes available via feature test macros such as `_BSD_SOURCE` which must be defined
before the headers are included.

For example, to enable the BSD extensions, one would need to do:

    #define _BSD_SOURCE
    #include <unistd.h>

but the contrary would not work:

    #include <unistd.h>
    #define _BSD_SOURCE

Remember that all extensions can be enabled at once via:

    _GNU_SOURCE

and that all feature test macros are defined under:

    man feature_test_macros

While not bare system calls, most of those wrappers have the same names and interfaces as the actual system calls,
and do very little processing of their own.

Also almost all portable system calls have a glibc wrapper.

The entire section 2 of `man` is about system calls. You should check:

- `man 2 syscalls`: list of system calls available on *most* architectures

- `man 2 syscall`: a function that allows to make direct system calls in c

To get info on specific system calls do:

    man 2 write
    man 2 reboot

#strace

List system calls made by executable.

Good way to investigate system calls.

Includes calls that load program.

    echo '#include <stdio.h>
    int main(void)
    { printf("hello"); return 0; }' > a.c

    gcc a.c
    strace ./a.out

#examples syscalls

this section shows system calls and what they do

required concepts needed to understand the sytem calls are also discussed here

##file descriptors

file descriptors contain know the position you are in the stream

file descriptors allow you to get/give data from anything outside ram:

- files
- devices (such as you mouse, keyboard, etc)

elated system calls are:

- open
- close
- write
- read

- get data to ram
- return no of bytes read if no error
- return error code if error
- increase position of fd

###lseek

reposition read/write

cannot be done on pipes or sockets

- dup
- dup2
- dup3
- fcntl

##files and dirs

- getcwdprocesses have working info associated
- chdir
- fchdirusing a file descriptor instead of string
- chrootuse new root (default `/` ) for paths starting with `/`
- creatcreate file or device. TODO: what is a device
- mknodcreate a directory or special or ordinary file
- linkcreate new name for file
- unlinkdelete hardlink to file. If it is the last, deletes the file from system.
- mkdir
- rmdir
- rename
- accesscheck real user's permissions for a file
- chmod

- chown
- fhownby file descriptor
- lchownno sym links

##sethostnameprocess have associated hostname info

##time

###timesince January 1, 1970
###stimeset system time
###timesprocess and waitee for time
###nanosleep
###utimechange access and modification time of files

##threads

###capget
###capset
###set_thread_area
###get_thread_area
###clone

creates thread: a process that can share open file descriptors and
memory

##process

###exit
###fork

creates process that is exact copy of current

open file descriptors TODO

###execve

run process. does not return on sucess: old program ends

common combo: fork before, then execve

###kill
###waitpid
###wait4
###waitid
###set_thread_area
###priority

process have a priority number from -20 to 19

lower number means higher priority

####nice
####getpriority
####setpriority

###ptraceTODO ?

###ids

every process has the following associated information:

####real and effective useriddefaults to user who executed process
####real and effective groupiddefaults to main group of user who executed process
####supplementary group ids
####parent id and parent groupdefaults to TODO effective or real of parent?

it is possible to change those values at runtime

####getuid, setuid, geteuid, seteuid, setresuid, getresuid

get set

nothing = real

e = effective

res = real, effective and save all at once

####getgroups setgroups

set suplementary group ids

####parent process

every process has information about its parent's id

#####getppidprocess parent id
#####getpgidprocess group id

##data segment size

###brkset
###sbrkincrement. called if heap is not large enough on `malloc`

##mount
##umount

##ipc

###signals

####signal
####sigactionhandler gets more info than with signal
####sys_pausewait for signal
####alarmsend alarm signal in n secs

###futex

basis for semaphores and posix pthread mutexes

####semaphores

shared integer resources that can be possessed and freed
indicating that other process may proceed

can be named or unnamed

in general each semaphore can have multiple values
(in real life they have 3!)

binary semaphore = a mutex

#####semget
#####semop
#####semtimedop
#####semctl

###pipecreate pipe
###pipe2pipe with flags

###flockadvisory

file lock

###sockets

main difference: can connect different computers!

####accept
####bind
####socket
####socketcall
####socketpair
####listen

###shared memory

TODO

###memory queues

TODO

###memory

###cacheflush

flush instruction or data cache contents

###getpagesize

get memory page size

#TODO

TODO what is `include/linux/syscalls.h`? cross arch calls?

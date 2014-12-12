# System call

This discusses system calls from an userland point of view. Kernel internals of system calls are not discussed here.

System calls that have very similar ANSI C, POSIX or glibc wrappers will get detailed explanations in those cheatsheets: this will only mention their existence, and comment on extensions not present in those wrappers. It is of course not a coincidence that those interfaces and the system calls are so similar, since:

- many system calls were designed to implement POSIX interfaces
- almost all architecture portable system calls have a glibc wrapper

System calls tell your OS to do things which user space program can't do directly such as:

- write to stdout, stderr, files
- exit a program
- reboot your computer
- file IO
- access devices
- process / threading threading management

All of those operations are ultra OS dependent, so when possible one should use portable wrappers libraries like ANSI C, the POSIX headers.

It is highly recommended that you also understand how to make system calls:

- directly from assembler to really understand them since they have a primary assembly interface. See [i386.asm](i386.asm) for some examples.
- glibc non-ANSI `syscall` macro. See [main.c](main.c).

System call interfaces are kept very stable since client code can rely directly on it. For this reason, some calls have multiple versions such as `dup`, `dup2` and `dup3`. This is unlike other kernel functions that can be used by device drivers, which are considered much more acceptable to break to make improvements.

System calls available on one architecture may differ from those available on another architecture.

Most of the more commonly used ones are available on all architectures.

There are a bit more than 350 system calls available on all architecture, although individual architectures can have many more. For example `alpha` has 505 syscalls as of `3.10-rc5`.

Each system call gets a number in order of addition to the kernel: this is called *syscall number*
This number can never be changed, but system calls may be declared deprecated.

TODO where to get the list of system calls on the source code tree.
The system calls are implemented on their corresponding section, e.g., filesystem related system calls go under `fs/`.

## Sources

This describes methods on how to get information on system calls without reading through the actual source code.

Note however that all of those methods have certain limits, and there might be no actual alternative to getting your hands dirty and reading the source.

TODO how to get a list of syscalls available on all architectures without grepping/processing kernel code?

TODO where are the descriptions of what a system call does in official docs (in the kernel tree for ideally?) Or bad / no docs as for the rest of the API?

### kernel.org

Official Linux kernel related domain.

Documentation at: <https://www.kernel.org/doc/>

#### man pages

Hosted under `kernel.org`, so does have some official endorsement: <https://www.kernel.org/doc/man-pages/>

The man pages project documents portable glibc C interfaces to system calls, which are very to the actual system calls.

The entire section 2 of `man` is about system calls. For general info see:

- `man 2 syscalls`: list of system calls available on *most* architectures
- `man 2 syscall`: a function that allows to make direct system calls in C

To get info on specific system calls do:

    man 2 write
    man 2 reboot

### POSIX

Linux is highly POSIX compatible, which means that many of its system calls exist to implement POSIX C library functions.

Often those functions have very similar names and arguments, and the POSIX descriptions are really good, which makes this a good way to learn what syscalls do.

POSIX is portable so in learning it you also learn an interface which works on many other systems.

POSIX functions are more basic than those which are not in POSIX but on the Linux API, so it is a good idea to start with them.

### Third-party compilations

The following sources don't seem to be explicitly endorsed by the Linux community, but are good nonetheless.

-   <http://syscalls.kernelgrok.com>

    Links to the C manpages and source code.

    Register arguments mnemonics.

-   <http://www.lxhp.in-berlin.de/lhpsysc0.html>

    Contains actual binary values of constants so you can make he calls from assembler.

## Return value

The return value of the system call is put into `eax` when the system call is finished.

That is the only way for the system call to communicate directly with the calling process: `errno` is TODO.

### Errors

System calls can fail for much more reasons than is the case with userspace function, since the kernel has to be careful and prevent processes from messing up the system.

In case of failure the program does not crash and no messages are printed: it is up to the programmer to check that the syscall succeeded via its return value.

By convention:

-   most system calls return 0 on success, -1 on failure.

    In those cases, the main goal is not getting the actual return of the system call, but doing some side effect with it.

-   some system calls can return positive integers in case of success, and -1 means failure.

    For example `write` returns the number of bytes written if successful.

    Since this can never be negative, `-1` is used for errors.

-   some system calls are always successful.

    This is the case for `getpid`, since all processes must have a PID, and any process has the privilege to view its own PID.

-   `getpriority` is a special case, since for historical reasons the nice or a process is represented between -20 and 19.

    The solution is that the system call is simply shifted from 0 to 39.

    This is possible because the range of nice is small.

    Wrapper libraries such as POSIX may then convert this to the nice value between -20 and 19.

-   a few system alls can return truly any positive or negative integers.

    This is the case for `ptrace`.

    In those cases, the system call returns the value via a pointer to a data.

    Then, on a higher level, glibc does:

        res = sys_ptrace(request, pid, addr, &data);
        if (res >= 0) {
            errno = 0;
            res = data;
        }
        return res;

    So that a user program has to do:

        errno = 0;
        res = ptrace(PTRACE_PEEKDATA, pid, addr, NULL);
        if (res == -1 && errno != 0)
                /* error */

### errno

`errno` is an ANSI C and POSIX library level concept that does not exist on the system call level,

It attempts to expose a simpler interface to user programs, always returning `-1` on errors and using `errno` to identify the error.

System calls return only a single register value, and it is up to the syscall wrappers to transform that value into a proper return value and set `errno`.

Beware that the `syscall` macro, while very low level syscall wrapper, still does return value and `errno` setting manipulations just in a similar way to the POSIX error handling.

## strace

List system calls made by executable.

Good way to investigate system calls.

Includes calls that load program.

    echo '#include <stdio.h>
    int main(void)
    { printf("hello"); return 0; }' > a.c

    gcc a.c
    strace ./a.out

## Sample syscalls

This section shows sample system calls and what they do.

Concepts needed to understand the system calls are briefly mentioned. Most concepts map to `struct`s, and to know what is going on you need to understand what fields the `struct` contains, i.e., what data is present in the concept model. E.g., the process `struct` has an associated `PID`, current directory, nice value, etc.

If the call has an analogue glibc wrapper, it will only be listed but not explained.

### File and directories

The concept of file descriptor exists much like in POSIX. They contain information such as position in the stream, and are represented by a `struct`

File descriptors:

- `open`
- `close`
- `write`
- `read`
- `lseek`
- `dup`
- `dup2`
- `dup3`
- `fcntl`

Files:

- `creat`
- `creatcreate`: file or device
- `mknodcreate`: a directory or special or ordinary file
- `linkcreate`: new name for file
- `unlinkdelete`: hardlink to file. If it is the last, deletes the file from system
- `mkdir`
- `rmdir`
- `rename`

Permissions:

- `chmod`
- `chown`
- `accesscheck`: real user's permissions for a file

Other:

- `fhownby`: file descriptor
- `lchownno`: symlinks
- `stat`

Filesystems:

- `mount`
- `umount`

### time

- `nanosleep`
- `stimeset`
- `time`
- `timesprocess`

### Threads and processes

- `capget`
- `capset`
- `chdir`
- `chrootuse`. Used to implement POSIX `chroot`.
- `clone`
- `execve`
- `exit`
- `fchdirusing`: a file descriptor instead of string
- `fork`
- `get_thread_area`
- `getcwd`: POSIX
- `ptrace`
- `kill`
- `set_thread_area`
- `set_thread_area`
- `sethostnameprocess`
- `utimechange`: access and modification time of files
- `wait4`
- `waitid`
- `waitpid`

Priority related calls:

- `nice`
- `getpriority`
- `setpriority`

IDs:

- `getuid`
- `setuid`
- `geteuid`
- `seteuid`
- `setresuid`
- `getresuid`
- `getppidprocess`: `man getppid`

Data segment size:

- `brk`

## TODO

The following needs some formatting.

### IPC

Signals:

- `signal`
- `sigaction`
- `futex`: used in POSIX pthread mutexes

##### Semaphores

Shared integer resources that can be possessed and freed
indicating that other process may proceed

Can be named or unnamed

In general each semaphore can have multiple values. In real life they have 3!

Binary semaphore = a mutex.

###### semget
###### semop
###### semtimedop
###### semctl

#### pipecreate pipe
#### pipe2pipe with flags

#### flockadvisory

File lock.

#### sockets

Main difference: can connect different computers!

##### accept
##### bind
##### socket
##### socketcall
##### socketpair
##### listen

#### shared memory

TODO

#### memory queues

TODO

#### memory

#### cacheflush

Flush instruction or data cache contents.

#### getpagesize

Get memory page size.

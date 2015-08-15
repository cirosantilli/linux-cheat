# System call

This discusses system calls from an userland point of view.

Only generic points are considered: for more specific discussions, see:

- <https://github.com/cirosantilli/assembly-cheat> for assembly low-level information
- <https://github.com/cirosantilli/cpp-cheat> for higher level POSIX and glibc wrappers

Almost all architecture portable system calls have wrappers, many very low level, since most system calls were designed to implement POSIX interfaces.

Almost all architecture portable system calls have a glibc wrapper.

System calls tell your OS to do things which user space program can't do directly such as:

- write to stdout, stderr, files
- exit a program
- reboot your computer
- file IO
- access devices
- process / threading threading management

All of those operations are ultra OS dependent, so when possible one should use portable wrappers libraries like ANSI C, the POSIX headers.

System call interfaces are kept very stable since client code can rely directly on it. For this reason, some calls have multiple versions such as `dup`, `dup2` and `dup3`. This is unlike other kernel functions that can be used by device drivers, which are considered much more acceptable to break to make improvements.

System calls available on one architecture may differ from those available on another architecture.

Most of the more commonly used ones are available on all architectures.

There are a bit more than 350 system calls available on all architecture, although individual architectures can have many more. For example `alpha` has 505 syscalls as of `3.10-rc5`.

Each system call gets a number in order of addition to the kernel: this is called *syscall number* This number can never be changed, but system calls may be declared deprecated.

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

## Bibliography

This describes methods on how to get information on system calls without reading through the actual source code.

Note however that all of those methods have certain limits, and there might be no actual alternative to getting your hands dirty and reading the source.

### Source code

For x86, see:

    src/arch/x86/syscalls/*.tbl

to get a list of the system call numbers and names, and then grep away the source.

There seems to be no simpler way.

There seems to be no documentation of what a system call does in official docs. The best way to go is to read the man pages for wrappers, and then the source itself.

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

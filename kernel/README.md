# Kernel

1.  Code
    1. [main.c](main.c)
    1. [hello_world](hello_world.c)
1.  [Introduction](introduction.md)
1.  [Build](build.md)
1.  [Use built kernel](use-built-kernel.md)
1.  [Source tree](source-tree.md)
1.  [Testing](testing.md)
1.  [Module](module.md)
    1. [Device driver](device-driver.md)
1.  [Virtual address space](virtual-address-space.md)
1.  [Scheduling](scheduling.md)
1.  [Virtualization](virtualization.md)
    1.  [User mode Linux](user-mode-linux.md)
    1.  [LXC](lxc.md)
    1.  [Lguest](lguest.md)
1.  [Debug](debug.md)
1.  [Style guide](style-guide.md)
1.  [Trivia](trivia.md)

WIP

1.  [Kconfig](kconfig.md)
1.  [Boot command line parameters](boot-command-line-parameters.md)
1.  [init](init.md)
1.  [Panic](panic.md)

## User programs

User programs such as a simple hello world run inside an abstraction called *process* defined by the kernel.

The kernel restricts what user programs can do directly basically to basic processor operations (adding) and memory operations (setting or getting RAM memory).

User programs can, however, ask the kernel to do certain operations for them via *system calls*.

A simple example is the C `printf` function, which must at some point ask the kernel to print to `stdout`, probably via the `write` system call.

Another simple example is file IO.

## Get current kernel version

    uname -r

Sample output:

    3.13.0-48-generic

TODO what does generic mean?

Or parse:

    cat /proc/version

Sample output:

    Linux version 3.13.0-48-generic (buildd@orlo) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #80-Ubuntu SMP Thu Mar 12 11:16:15 UTC 2015

## Interruptions

-   user space process can be interrupted by anything, including other user space processes.

-   kernel space processes can be interrupted by other kernel processes or interrupts handlers, but not by user space processes.

    Examples of things that generate kernel space processes:

    - system calls
    - module insertion/removal
    - scheduled kernel processes such as softirqs.

        those are run in kernel threads

-   interrupt handlers cannot be interrupted by anything else, not even other interrupt handlers.

## x86 specifics

This section discusses issues specific to the x86 Linux implementation.

### Exceptions

Intel reserves interrupt numbers from 0 to 31 for exceptions: anormal execution of instructions such as division by zero, or accessing forbidden memory areas.

Certain interrupt numbers are processor interrupts called exceptions.

Linux deals with those interrupts in interrupt handlers, and then if a user process generates one of those exceptions, the process is notified via a predefined signal.

    0   Divide error                    SIGFPE
    1   Debug                           SIGTRAP
    2   NMI                             None
    3   Breakpoint                      SIGTRAP
    4   Overflow                        SIGSEGV
    5   Bounds check                    SIGSEGV
    6   Invalid opcode                  SIGILL
    7   Device not available            None
    8   Double fault                    None
    9   Coprocessor segment overrun     SIGFPE
    10  Invalid TSS                     SIGSEGV
    11  Segment not present             SIGBUS
    12  Stack segment fault             SIGBUS
    13  General protection              SIGSEGV
    14  Page Fault                      SIGSEGV
    15  Intel-reserved                  None
    16  Floating-point error            SIGFPE
    17  Alignment check                 SIGBUS
    18  Machine check                   None
    19  SIMD floating point             SIGFPE

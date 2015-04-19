# Kernel

1.  Code
    [main.c](main.c)
    [hello_world](hello_world.c)
1.  [Introduction](introduction.md)
1.  [Compile and install](compile-and-install.md)
1.  [Testing](testing.md)
1.  [Source tree](source-tree.md)
1.  [Module](module.md)
1.  [Virtual address space](virtual-address-space.md)
1.  [Scheduling](scheduling.md)
1.  [Style guide](style-guide.md)

WIP

1. [dmesg](dmesg.md)
1. [LXC](lxc.md)

## User programs

User programs such as a simple hello world run inside an abstraction called *process* defined by the kernel.

The kernel restricts what user programs can do directly basically to basic processor operations (adding) and memory operations (setting or getting RAM memory).

User programs can, however, ask the kernel to do certain operations for them via *system calls*.

A simple example is the C `printf` function, which must at some point ask the kernel to print to `stdout`, probably via the `write` system call.

Another simple example is file IO.

## Version number

- rc = Release Candidate

## Get kernel version

    uname -r

Or:

    cat /proc/version

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

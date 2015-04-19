# Virtual address space

How the kernel fits multiple processes, kernel and user, into a single RAM.

## Prerequisites

Before reading any of this, *understand paging on a popular architecture* such as x86. Even better, learn it on a second popular platform such as ARM, which will make it clearer how the kernel why the kernel chooses certain models that will fit many platforms.

The kernel uses complicated features of the CPU to manage paging, so if you don't understand those it will be impossible to understand what is being said here.

Good source on the subject: <http://stackoverflow.com/questions/18431261/how-does-x86-paging-work>.

## Sources

Free:

-   good beginner's tutorial: <http://duartes.org/gustavo/blog/post/anatomy-of-a-program-in-memory>

-   good tutorial: <http://www.bottomupcs.com/virtual_address_and_page_tables.html>

-   [Rutgers lecture notes on Memory Management](http://www.cs.rutgers.edu/~pxk/416/notes/09-memory.html)

    Good info on the historical development of virtual adress space techniques.

Non-free:

-   Bovet - 2005 - Understanding the Linux Kernel. Chapter "Memory Addressing".

    Good info on the x86 memory hardware.

## Goals of a virtual memory space

-   allow multiple programs to share a single RAM, while having the convenient illusion that their memory is contiguous.

    It would be hard to do this without paging because the memory size of programs changes with time and is not predictable.

-   protection: control which addresses process can or cannot use.

    For example, processes cannot accesses pages of another process, specially the kernel itself!

    If a page cannot be found in the page table of a process then the processes does not have the right to access it.

-   swap to disk: allow for programs to use more RAM than is available.

    It suffices to store a flag indicating if memory is on main memory or on disk, and if it is on disk then the address indicates the disk address of the page.

-   fast process switch.

    Switching the entire processes in memory comes down to a single operation of changing the page table in use.

## Ancient approaches

In order to understand why virtual memory via paging is good, it is a good idea to see older solutions to the problem and why they were not good enough.

[This tutorial][rutgers-memory] is a good source of such information.

## Hardware support

RAM memory access is one of the most common operations done by a program.

Therefore if any control is to be done at every single memory operation, it must be *very* fast. This is why most architectures have some hardware support for those control operations.

It is then necessary to first understand how those hardware circuits work. Architecture specifics shall not be discussed here: look for specific info on each Architecture.

A good place to start is with x86 paging circuitry.

As usual, Linux adopts a single unified model that covers several architectures.

## Virtual memory space for a single process

The process memory space is divided as follows:

    kernel

    ------------------
                      |
                      | random stack offset
                      |
    ------------------ <== TASK_SIZE

    stack

    ||| (grows down)
    vvv

    ------------------


    ------------------ <== RLIMIT_STACK
                      |
                      | random mmap offset
                      |
    ------------------

    memory mapping

    ||| (grows down)
    vvv

    ------------------

    ------------------ <== brk

    ^^^
    ||| (grows up)

    heap

    ------------------ <== start_brk
                      |
                      | random brk offset
                      |
    ------------------

    BSS

    ------------------ <== end_data

    data

                       <== start_data
    ------------------ <== end_code

    text

    ------------------ <== 0x08048000

    ------------------ <== 0

## Valid addresses

Valid program accesses:

- `RW` on: data, BSS, heap, memory mappings and stack
- `R` on: text

If a process tries to access addresses between TASK_SIZE and RLIMIT_STACK the kernel may allow its stack to grow.

Any other access attempt will generate a TODO page or seg fault?

## Kernel segment

Never changes between processes.

`TASK_SIZE` is typically 3/4 of the total memory.

Note that this is *virtual* memory, so it is independent of the actual size of the memory as the hardware and the kernel can give processes the illusion that they actually have amounts of memory larger than the hardware for instance.

## ASLR

## Address space layout randomization

## Random offset segments

<http://en.wikipedia.org/wiki/Address_space_layout_randomization#Linux>

Randomly generated for each process to avoid attacks.

Must be small not to take too much space.

## Stack

Grows down.

May be allowed to increase by the OS access is done before the maximum stack value `RLIMIT_STACK`.

## Memory mapping

Created via `mmap` system calls.

Stores dynamically loaded library code.

## Heap

Usually managed by language libraries such as C `malloc`.

Manipulated on the system level by the `brk` syscall.

## BSS

Uninitialized variables.

No need to store their value on the binary file, only need to reserve space for them after startup.

Does not change size.

## Data

Initialized variables.

Directly copied from the executable file.

## Text

Code to be executed + certain char strings.

Is directly copied from the executable file.

## Page

First learn about hardware paging in a common architecture such as x86 family. This will be not explained here.

Pages are modeled by `struct page` under `mm_types.h`.

Hardware deals in terms of pages to:

- make retrieval faster, since the bus clock is much slower than the cpu clock and because of memory locality.
- serve as a standard unit for page swap between RAM and HD.

### Page flags

Defined in `page-flags.h`.

### Page frame

A page frame refers to the smallest physical memory that the processor can ask from the RAM.

Paging usually has hardware support today.

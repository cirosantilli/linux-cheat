# Introduction

Besides the Linux kernel, what most people call a Linux system, or more precisely a Linux distribution, must also contain many more user level basic services such as the python interpreter, the X server, etc. The extra user space services are specified by the LSB, and are not a part of the Linux kernel.

## What is the Kernel written in

The Linux kernel is written on mainly on C99 standard with GCC extensions, which it uses extensively, both on points which cannot be done in any other way without the extensions (inline assembly), but also at points where those are not strictly necessary, for example to improve debugging and performance.

The C code defines higher level interfaces, which must be implemented in assembly for each ISA.

You cannot use user space libs such as libc to program the kernel, since the kernel itself itself if need to be working for user space to work.

You cannot use floating point operations on kernel code because that would incur too much overhead of saving floating point registers on some architectures, so don't do it.

## What the kernel does

The kernel does the most fundamental operations such as:

-   **user permission control**

    The kernel determines what programs can do or not, enforcing for example file permissions.

-   **virtual address space**

    All programs see is a virtual address space from 0 to a max size, even if the physical memory may be split in a complex way in the physical RAM.

    If they try write out of this space, the kernel terminates them, so that they don't mess up with other process memory.

    This also increases portability across different memory devices and architectures.

-   **filesystem**

     The kernel abstracts individual filesystems into a simple directory file tree easily usable by any program, without considering the filesystem type or the hardware type (hd, flash device, floppy disk, etc.)

-   **concurrence**

    The kernel schedules programs one after another quite quickly and in a smart way, so that even users with a single processor can have the impression that they are running multiple applications at the same time, while in reality all they are doing is switching very quickly between applications.

-   **virtualization**

    The kernel can make a single system look like multiple systems, e.g. to allow code to be run in a well determined environment. The subsystem that does this is called LXC: `Linux Containers`, and is exploited in applications such as Docker.

Therefore it reaches general goals such as:

- increasing code portability across different hardware and architectures
- creating useful and simple abstractions which programs can rely on (contiguous RAM memory, files, processes, user permissions, etc.)

## POSIX

Of of the goals of Linux is to highly (but to 100%) POSIX compliant.

Therefore, many of its system calls and concepts map directly to POSIX concepts.

We strongly encourage you to look at exactly what POSIX specifies and what it does not, so as to be able to decide if your code cannot be made more portable by using the POSIX C API instead of Linux specific code.


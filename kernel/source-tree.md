# Source tree

It is fundamental that you understand the global architecture of kernel code so that you are able to find what you are looking for, and contribute to the kernel.

## Sizes

Top folders by size of a compiled `v3.10-rc5` kernel:

    3.7G    drivers
    727M    net
    598M    fs
    334M    sound
    255M    arch

## arch

Architecture specific code. Ex: `x86`, `sparc`, `arm`.

`/arch/XXX/include/`

## asm

`asm` directories contains header files which differ from one architecture to another.

Those files are used on source as `asm/file.h`, and the make process ensures that they point to the target compilation architecture.

During compilation, the Makefile uses the correct architecture includes and definitions.

Most `asm` directories are subdirectories of `arch/XXX/include/`.

Even though the code in those headers is architecture dependant, it is possible to use some interfaces on arch portable code since those are implemented on all archs, and this is done throughout the kernel as a `grep -r asm include/linux` will reveal. It is not however true that all interfaces provided are reliable on all platforms. TODO which ones exactly can be used on all platforms? <http://stackoverflow.com/questions/17674452/linux-kernel-which-asm-headers-symbols-macros-are-available-on-all-architect>

## crypto

Cryptography.

## uapi

`uapi` contains arch dependant stuff that will be exposed to userspace applications: <http://lwn.net/Articles/507794/>

An example is system calls macro numbers such as `__NR_WRITE`.

TODO how do user programs use import those headers?

## generated

Files under such directories have been generated programmatically from other files.

An example in `3.10-rc5` is `arch/x86/include/generated/uapi/asm/unistd_32.h` which contains the `__NR_XXX` system call macro numbers.

One major application of this is to ignore those files from source control. The following is a quote from the `3.10-rc5` `.gitignore`:

    #
    # Generated include files
    #
    include/config
    include/generated
    arch/*/include/generated

## include/linux

Default places for almost all important headers for interfaces that can be used across the kernel.

Some subsystems however are large enough to merit separate directories in include such as `net` which holds the networking includes.

Important files include:

- `sched.h`:    scheduling and task key structures
- `fs.h`:       key filesystem structures
- `compiler.h`: compiler related stuff such as `__user`, which expands to a GCC `__attribute__`.
- `types.h`:    typedefs

## include/asm-generic

Holds declarations of things that are defined in assembly.

Possible rationale: make it clear what new ports will need to implement; things that are not there are defined in C, so no need to port those.

It is a very fun to explore part of the code as it is a gateway for low level code.

<http://stackoverflow.com/questions/3247770/what-is-the-linux-2-6-3x-x-include-asm-generic-for>

## Documentation

Kernel documentation.

Very incomplete.

Important files and directories:

- `DocBook`: documentation automatically generated from well formatted source code comments.

## init

Initialization code. Specially important is `main.c` which ties the whole kernel together.

## kernel

TODO

## lib

Kernel global boilerplate:

- data structures such as linked lists in `llist.c` or `rbtree.c`

## tools

TODO what is the difference from `lib`?

Seems to contain utilities which are useful throughout the kernel, such as:

- `EXPORT_SYMBOL` under `perf/util/include/linux/export.h`

## scripts

Scripts used to build the kernel.

## driver

Device drivers. Contains the majority of the kernel's code, as this must support every single hardware ever contributed to the tree.

Some vendors decide to only provide binary blobs as drivers.

## net

Networking code.

## fs

Filesystems code.

## sound

Sound code.

## mm

Memory management.

## IPC

IPC stuff such as semaphores under `sem.c` or message queues under `mqueue.c`.

## Find definitions

A possible way to find and navigate the kernel source code is via: `ctags`.

Also consider `ack` or good and old GNU `grep -r`.

For example, to try to find the definition of `struct s`:

    ack '^struct s \{'

## usr/include/linux vs usr/src/linux-headers

<http://stackoverflow.com/questions/9094237/whats-the-difference-between-usr-include-linux-and-the-include-folder-in-linux>

-   `/usr/include/linux` is owned by libc on Linux, and used to call kernel services from userspace. TODO understand with a sample usage

-   `/usr/src/linux-headers-$(uname -r)/include/linux/` is exactly part of the kernel tree under `include` for a given kernel version.

    Can be used to offer access to the kernel's inner workings.

    It is useful for example for people writing kernel modules, and is automatically included by the standard module `Makefile`.

## System.map

Generated at the top level and then placed at `/boot/System.map-<version>`.

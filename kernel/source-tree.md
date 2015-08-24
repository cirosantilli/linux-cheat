# Source tree

It is fundamental that you understand the global architecture of kernel code so that you are able to find what you are looking for, and contribute to the kernel.

## Sizes

Top folders by size of a clean `v3.10-rc5` kernel:

    330M    drivers
    172M    tags
    131M    arch
    37M fs
    32M include
    30M Documentation
    29M sound
    26M net
    8.4M    tools
    6.7M    kernel
    6.1M    firmware
    3.6M    scripts
    3.4M    lib
    3.0M    mm
    2.9M    crypto
    2.3M    security
    1.2M    block

## arch

Architecture specific code. E.g.:

- `x86`: mixture of IA-32 and x86-64
- `arm`
- `sparc`
- `powerpc`

### x86

### IA-32

### x86-64

Contains both IA-32 and x86_64. A large part is factored out between the two, specifics are distinguished by:

- `32` or `64` on the filename
- `#ifdef __i386__` in the code

System calls:

-   `arch/x86/syscalls/syscal_32.tbl`, `arch/x86/syscalls/syscal_64.tbl`: maps system call numbers to the methods.

    - TODO what is `common` vs `x32` vs `64` in the `64.tbl` file?
    - TODO `stub` functions like `stub_fork`: <http://stackoverflow.com/questions/23734170/why-do-certain-linux-x86-64-system-calls-require-a-stub>

-   `arch/x86/kernel/entry_32.S`, `arch/x86/kernel/entry_64.S`: the low level system call handling

## asm

`asm` directories contains header files which differ from one architecture to another.

Those files are used on source as `asm/file.h`, and the make process ensures that they point to the target compilation architecture.

During compilation, the Makefile uses the correct architecture includes and definitions.

Most `asm` directories are subdirectories of `arch/XXX/include/`.

Even though the code in those headers is architecture dependant, it is possible to use some interfaces on arch portable code since those are implemented on all archs, and this is done throughout the kernel as a `grep -r asm include/linux` will reveal. It is not however true that all interfaces provided are reliable on all platforms. TODO which ones exactly can be used on all platforms? <http://stackoverflow.com/questions/17674452/linux-kernel-which-asm-headers-symbols-macros-are-available-on-all-architect>

## crypto

Cryptography.

The kernel can use CPU-specific cryptographic instructions, e.g. <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/x86/crypto?id=refs/tags/v4.0>

This is a bit polemic, since some states restrict cryptographic software in a similar way to weapons.

## include

Headers used across the kernel.

Very important, as it contains all major structures, and understanding structures is the first step to understanding programs. The next one is how they are manipulated.

### uapi

User API.

Contains arch headers that will be exposed to userspace applications: <http://lwn.net/Articles/507794/>

Example application: ABI for making system calls. System calls are of course visible from user space, and some of them take structures. A `.h` file can then give the C `struct` that must be passed to the system call, e.g. via the glibc `<sys/syscall.h>`.

Those headers may also contain:

- some small `static inline` methods, mostly ones that operate directly on the 
- defined constants, mostly flags to operate on the structs

Those headers can be exported for userspace usage with `make headers_install`.

Modules for instance can import many other headers, and use their implementation loaded in the Kernel code in memory.

### include/linux

Generic headers. Contains some of the most fundamental headers of the kernel:

- `sched.h`: scheduling and task key structures, e.g. `task_struct`
- `arch/x86/include/asm/ptrace.h`: `pt_regs` which models the x86 registers
- `fs.h`: key filesystem structures
- `types.h`: typedefs
- `compiler.h`: compiler related stuff such as `__user`, which expands to a GCC `__attribute__`

### include/asm-generic

Holds declarations of things that are defined in assembly.

Possible rationale: make it clear what new ports will need to implement; things that are not there are defined in C, so no need to port those.

It is a very fun to explore part of the code as it is a gateway for low level code.

<http://stackoverflow.com/questions/3247770/what-is-the-linux-2-6-3x-x-include-asm-generic-for>

## generated

Files under such directories have been generated programmatically from other files and are gitignored.

An example in `3.10-rc5` is `arch/x86/include/generated/uapi/asm/unistd_32.h` which contains the `__NR_XXX` system call macro numbers.

One major application of this is to ignore those files from source control. The following is a quote from the `3.10-rc5` `.gitignore`:

    #
    # Generated include files
    #
    include/config
    include/generated
    arch/*/include/generated

## defconfig

E.g.:

    arch/x86/configs/i386_defconfig
    arch/x86/configs/x86_64_defconfig

TODO. One per architecture.

Seems to be used as the default for the `.config` on a given platform.

You can select an explicit arch to initialize `.config` with:

    make defconfig ARCH=um

## Documentation

Kernel documentation.

Very incomplete: the source is the final doc :-)

Important files and directories:

- `DocBook`: documentation automatically generated from well formatted source code comments.

Also consider `make mandocs`, which builds manpages from well formated function comments.

### Documentation/ABI

Documents stable APIs that the kernel exposes. Basically system calls and `sysfs`.

## init

Initialization code. Specially important is `main.c` which ties the whole kernel together.

## kernel

Seems to contain any topic that did not fall in other directories, e.g. `fs`, `net`, `crypto`.

Some important directories it contains:

- `sched`
- `time`

## lib

Kernel global boilerplate:

- data structures such as linked lists in `llist.c` or `rbtree.c`

## tools

TODO what is the difference from `lib`?

Seems to contain utilities which are useful throughout the kernel, such as:

- `EXPORT_SYMBOL` under `perf/util/include/linux/export.h`

## scripts

Various scripts, and most importantly the ones used to build the kernel.

`Makefile.build` and `Kbuild.include` are central build files.

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

## Firmware

TODO confirm this.

Contains mostly `ihex` files, which represent binary data.

Firmware are sequences of bytes that get saved to persistent memory inside of devices.

Firmware exists so that manufacturers can update how their hardware works after selling the hardware.

The actual meaning of the bytes of the of firmware is undocumented: end users only gets blobs, and the manuals say: using blob version X, the device works as such. There are many tutorials on the net however.

Likely manufacturers feel it would give too much insight into their internal design.

Therefore, the only way for end users to modify firmware themselves is to reverse engineer the device's inner workings, which is hard and uncertain.

This also means that firmware could be a source of security vulnerability, as it is an undocumented feature of the hardware.

The Linux kernel must fix firmware feed to devices so that they are in a known documented state, against which drivers can be coded.

## Vocabulary

### Sub-leaves

In the context of CPUID and `/proc/cpuinfo`, most CPUID take a single input: eax.

But recent CPUID instructions are also taking ecx as a second level after eax, thus the leaf of a two level tree.

The linux kernel is written on mainly on C99 standard,with **gasp** gcc extensions,
which it uses extensively, both on points which cannot be done in any other way without the extensions (inline assembly),
but also at points where those are not strictly necessary, for example to improve debugging and preformance.

Besides the linux kernel, what most people call a linux system, or more precisely
a linux distribution, must also contain many more user level basic services such as the python
interpreter, the X server, etc.
The extra user space services are specified by the lsb, and are not a part of the linux kernel.

You cannot use user space libs such as libc to program the kernel,
since the kernel itself itself if need to be working for user space to work.

#examples portability

All code samples were tested on kernel 3.10.

#sources

Consider reading books on general operating system concepts,
as those tend to explain better concepts which are used on Linux
as well as other OS.

Linux documentation kind of sucks.

Most function definitions or declarations don't contain any comments,
so you really need to have a book in your hands to understand things.

Therefore, the only way to understand things is to hope to find them on some book,
and if not, interpret source codes, which are possibly very convoluted for performance
and other complex restrictions.

Maybe there is a good reason for that.

##free sources

[free-electrons]: http://lxr.free-electrons.com/ident

- [free-electrons][]

    One of the best ways of searching where things are defined / declared on the source code.

    Possible alternatives: ctags and grep.

- `grep -R`

    Possible way to find where something is defined.

    May take a long time on the rource root, and it may be hard to get the actual definitions,
    but it does works sometimes.

- `ctags -R`

    Better than grep to find where things are defined / declared.

    Doing:

        ctags -R --c-kinds=-m

    on the kerne root generated a file of 134M, but this might be worth it as it may save lots of grepping time.

    You will might then want to add the following to your `.bashrc`:

            function ctag { grep "^$1" tags; } #CTAgs Grep for id
            function rctag { cd `git rev-parse --show-toplevel` && grep "^$1" tags; }

    Another similar option is to use [free-electrons][].

[kernel-org]: https://www.kernel.org/doc/

- [kernel-org][]

    kernel.org resources list

- `git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git`

    The source code, *the* only definitive source.

    The builtin docs are not very good though.

- `make htmldoc` on the source.

    Generates documentation for the kernel from comments, and puts it under `Documentation/DocBook/index.html`

    The most useful is under `kernel api`. Still, this is grossly incomplete.

    The documentation seems to be stored in the `.c` files mostly rather than on the `.h`.

    Weirdly the snapshots of htmldoc on kernel.org have some extra functions, check it out:
    <https://www.kernel.org/doc/htmldocs/kernel-api.html>

[kernel-org]: https://www.kernel.org/doc/

- [kernel-org][]

    kernel.org resources list

[kernelnewbies]: http://kernelnewbies.org/

- [kernelnewbies][]

[kernel-mail]: http://vger.kernel.org/vger-lists.html

- [kernel-mail][]

    Kernel mailing lists.

    Mostly bleeding edge design decisions.

##payed sources

###books on general operating systems

[stallings11]: http://www.amazon.com/Operating-Systems-Internals-Principles-Edition/dp/013230998X

- [stallings11][]

###books on the linux kernel

[corbet05]: http://www.amazon.com/books/dp/0596005903

- [corbet05][]

    Shows lots of kernel to kernel interfaces, but not the internals.

    Tons of examples.

    Good first linux book read.

[bovet05]: http://www.amazon.com/books/dp/0596005652

- [bovet05][]

    Inner workings.

    Reasonable info on x86 hardware.

[love06]: http://www.amazon.com/books/dp/0596005652

- [love06][]

    Love - 2006 - Linux kernel devlopement.

#what the kernel does

the kernel does the most fundamental operations such as:

- **user permission control**

    the kernel determines what programs can do or not,
    enforcing for example file permissions

- **virtual address space**

     all programs see is a virtual address space from 0 to a max size,
     even if the physical memory may be split in a complex way in the physical RAM

     if they try write out of this space, the kernel termiates them,
     so that they don't mess up with other process memory

     this also increases portability across different memory devices and architectures.

- **filesystem**

     the kernel abstracts individual filesystems into a simple directory file tree
     easily usable by any program, without considering the filesystem type or
     the hardware type (hd, flash device, floppy disk, etc)

- **concurrence**

     the kernel schedules programs one after another quite quickly and in a smart way,
     so that even users with a single processor can have the impression that they are
     running multiple applications at the same time, while in reality all they are doing
     is switching very quicly between applications.

therefore it reaches general goals such as:

- increasing code portability across different hardware and architectures
- creating useful and simple abstractions which programs can rely on
	(contiguous RAM memory, files, processes, user permissions, etc)

#posix

of of the goals of linux is to highly ( but to 100% ) POSIX compliant

therefore, many of its system calls and concepts map directly to POSIX concepts

we strongly incourage you to look at exactly what POSIX specifies
and what it does not, so as to be able to decide if your code cannot be made
more portable by using the posix c api instead of Linux specific code.

#source tree

It is fundamental that you understand the global architecture of kernel code
so that you are able to find what you are looking for, and contribute to the kernel.

##sizes

Top folders by size of a compiled v3.10-rc5 kernel:

    3.7G    drivers
    727M    net
    598M    fs
    334M    sound
    255M    arch

##arch

Architecture specific code. Ex: `x86`, `sparc`, `arm`.

`/arch/XXX/include/`

##asm

`asm` directories contains header files which differ from one architecture to another.

Those files are used on source as `asm/file.h`, and the make process ensures that they
point to the target compilation architecture.

During compilation, the Makefile uses the correct architecture includes and definitions.

Most `asm` directories are subdirectories of `arch/XXX/include/`.

Even though the code in those headers is architecture dependant, it is possible to use
some interfaces on arch portable code since those are implemented on all archs,
and this is done throughout the kernel as a `grep -r asm include/linux` will reveal.
It is not however true that all interfaces provided are reliable on all platforms.
TODO which ones exactly can be used on all platforms? <http://stackoverflow.com/questions/17674452/linux-kernel-which-asm-headers-symbols-macros-are-available-on-all-architect>

##uapi

`uapi` contains arch dependant stuff that will be exposed to userspace applications: <http://lwn.net/Articles/507794/>

An example is system calls macro numbers such as `__NR_WRITE`.

TODO how do user programs use import those headers?

##generated

Files under such directories have been generated programatically from other files.

An example in 3.10-rc5 is `arch/x86/include/generated/uapi/asm/unistd_32.h` which contains the `__NR_XXX`
system call macro numbers.

One major application of this is to ignore those files from source control. The following is a quote from the
`3.10-rc5` `.gitignore`:

    #
    # Generated include files
    #
    include/config
    include/generated
    arch/*/include/generated

##include/linux

Default places for almost all important headers for intefaces that can be used across the kernel.

Some subsystems however are large enough to merit separate directories in include such as `net` which
holds the networking includes.

Important files include:

- `sched.h`:    scheduling and task key structures
- `fs.h`:       key filesystem structures
- `compiler.h`: compiler related stuff such as `__user`, which expands to a gcc `__attribute__`.
- `types.h`:    typedefs

##include/asm-generic

Holds declarations of things that are defined in assembly.

Possible rationale: make it clear what new ports will need to implement;
things that are not there are defined in C, so no need to port those.

It is a very fun to explore part of the code as it is a gateway for low level code.

<http://stackoverflow.com/questions/3247770/what-is-the-linux-2-6-3x-x-include-asm-generic-for>

##Documentation

Kernel documentation.

Very incomplete.

Important files and directories:

- `DocBook`: documentation automatically generated from well formatted source code comments.

##init

Initialization code. Specially important is `main.c` which ties the whole kernel together.

##kernel

TODO

##lib

Kernel global boilerplate:

- data structures such as linked lists in `llist.c` or `rbtree.c`

##tools

TODO what is the difference from `lib`?

Seems to conatin utilities which are useful throughout the kernel, such as:

- `EXPORT_SYMBOL` under perf/util/include/linux/export.h

##scripts

Scripts used to build the kernel.

##driver

Device drivers. Contains the majority of the kernel's code.

##net

Networking code.

##fs

Filesystems code.

##sound

Sound code.

##mm

Memory management.

##ipc

IPC stuff such as semaphores under `sem.c` or message queues under `mqueue.c`.

##find definitions

A possible way to find and navigate the kernel source code is via: ctags.

Also consier `ack` or good and old GNU `grep -r`.

For example, to try to find the definition of struct `s`:

    ack '^struct s \{'

##usr/include/linux vs usr/src/linux-headers

<http://stackoverflow.com/questions/9094237/whats-the-difference-between-usr-include-linux-and-the-include-folder-in-linux>

- `/usr/include/linux` is owned by libc on linux, and used to call kernel services from userspace.
	TODO understand with a sample usage

- `/usr/src/linux-headers-$(uname -r)/include/linux/` is exactly part of the kernel tree under `include`
	for a given kernel version.

	can be used to offer access to the kernel's inner workings

	it is useful for example for people writting kernel modules,
	and is automatically included by the standard module `Makefile`.

##System.map

Generated at the top level and then placed at `/boot/System.map-<version>`.

#special files

The kernel communicates parameters to user space using special files,
located mainly under `/proc/`, `/sys/` and `/dev/`.

Those files are not stored in permanent storage (HD), only in RAM.
They can still be accessed via open, read and write system calls,
therefore they can be manipulated from sh via `cat` and redirection.

What those system calls do exacty depends on what the `file_operations`
struct associated to the file was programmed to do.

Certain utilities are implemented on Linux not via system calls,
but by interpreting `proc` information of specific files.
For example, `ps` finds process information through the `proc` filesystem.
One can therefore rely on those interfaces ( which files outputs information in which format).

TODO0 why is it advantages to use special files instead of system calls? Is it useful mostly to handle information
for which the output size is unkonwn, by reusing file io operations?

##proc filesystem

Offer access system information ot user processes.

Some interesting files include:

- numeric directories: `/proc/1/`, `/proc/2/`, ...:

    Contain standard directory structures with process info.

    This is why that dir is called `/proc`

- `cat /proc/version`: linux kernel version and other system info. Similar to `uname -a` output.

- `cat /proc/cpuinfo`: information on cpu

- `cat /proc/meminfo`: information on RAM memory

- `cat /proc/slabinfo`: slab allocator info

- `cat /proc/softirqs`: softirq info

- `cat /proc/partitions`: softirq info

- `cat /proc/sched_debug`: scheduler info for debugging

- `cat /proc/modules`: information on modules

- `cat /proc/devices`: information on registered character and block devices.

    Does not consider files under `/dev/`, but registrations done for example via `alloc_chrdev_region`.

    Sample lines:

        Character devices:
        1 mem
        4 tty

    Which say that:

    - major number 1 is taken device named `mem`
    - major number 4 is taken device named `tty`

    where the device name is what was passed to the `alloc_chrdev_region` call.

- `sudo cat /proc/kallsyms | less`: list of kernel symbols

    Sample output lines:

        c10010c0 t do_signal
        c1001980 T do_notify_resume
        ^        ^ ^
        1        2 3

    Fields:

    1. address
    2. type. Same as used by the `nm` utility.
    3. id

TODO where are those documenteded?

##dev filesystem

Represent devices, either physical or virtual.

###sda

Device files of this type represent block devices such as hard disks or flash memory.

The first device is `sda`, the second `sdb`, and so on.

Also, partitions inside those devices have device files for them too.

The first primary partion inside `sda` will be called `sda1`,
the second main partition `sda2`, and so on.

Logical partitions are numbered from `sda5` onwards.

*Warning*: usage of block devices can be very dangerous and lead to data loss!

Example: copy a block device on `/dev/sda/` to the one one `/dev/dsb`:

    #sudo dd bs=4M if=/dev/zero of=/dev/sdb

this could be used to make a full system backup.

Example: write pseudorandom sequences into `/dev/sda/` to hide data:

    #sudo dd bs=4M if=/dev/urandom of=/dev/sda

###null

Discards whatever input is given to it by a `write` sycall

Very useful to discard undesired stdout / stderr:

    echo a > /dev/null

Generates no output.

###zero

Returns as many zeros as asked for by a read syscall.

You cannot `cat` this because cat reads until the file is over,
but this special file is *never* over.

Application: reset entire partitions to 0.

Example:

    dd if=/dev/zero count=1 status=none | od -Ax -tx1

Output:

    000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    *
    000200

Meaning if you don't speak `od` language (now is a good time to learn):
512 bytes with value 0.

###full

if you write to it, the write returns ENOSPC error

Example:

    echo a > /dev/full

If you read from it, returns as many null chars as were asked for by read, like `/dev/zero`.

###pseudorandom number generators

The kernel implements a random number generator which draws entropy from
non predictable events, typically device events such as mice movements
or disk reads for example.

Just like for `/dev/zero`, it is useless to cat those files,
since they don't have and end, and `cat` tries to read to the end of the file before printing.

####random

`/dev/random` returns random numbers one by one whenever enough entropy
is generated. It is slower than `urandom`, but has greater entropy.

####urandom

`/dev/urandom` returns random numbers continuously. It is faster than `random`,
but has less entropy. It should however be good enough for most applications.

Example: get 16 random bytes:

    dd bs=16 if=/dev/urandom count=1 status=none | od -Ax -tx1
    dd bs=16 if=/dev/urandom count=1 status=none | od -Ax -tx1

Sample output:

    000000 51 e6 4d 6d 98 5f 3e 48 c9 9a 04 6f d7 f2 57 c6
    000010

    000000 7d 87 2c a3 32 9d d0 78 18 9d 5f ab c5 7a d2 ea
    000010

Since the 16 bytes are random, the lines are extremelly likelly to be different.

###mice

you can have some fun with mouses. Search for the mice or mouse device files and cat them:

	sudo cat /dev/input/mice

and then:

	sudo cat /dev/input/mouse0

now note that when you move the mouse, cat spits something out to the screen!

`mice` is the combination of all mice, and each other `mouseX` is a single mouse device.

##sys filesystem

TODO

#user programs

User programs such as a simple hello world run inside an abstraction called *process* defined by the kernel.

The kernel restricts what user programs can do directly basically to basic processor operations (adding)
and memory operations (setting or getting RAM memory).

User programs can, however, ask the kernel to do certain operations for them via *system calls*.

A simple example is the c `printf` function, which must at some point ask the kernel to print to `stdout`,
probably via the `write` system call.

Another simple example is file io.

#floating point

Uou Cannto use floating point operations on kernel code because that would incur too much overhead
of saving floating point registers on some architectures, so don't do it.

#rings

x86 implemented concept

programs can run in different rings

4 rings exist

linux uses 2:

- 0: kernel mode
- 3: user mode

this is used to separate who can do what

#version number

- rc = Release Candidate

#compile

Get the source:

	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

clean everything:

	make mrproper

generate the `.config` file:

	make menuconfig

this opens up a ncurses interface which allows you to choose amongst tons of options
which determine which features your kernel will include or not.

then go on to `save` to save to the `.config` file and then exit

many of the options of the configuration file can be accessed via preprocessor macros
which control system behaviour (TODO all of them are accessible?)

for example:

    CONFIG_SMP=y

means that symmetrical multiprocessing is on (yes), and then in the code we can use:

    #ifdef CONFIG_SMP
        //smp specific
    #endif

build:

	make -j5

`-j` tells make to spawn several process, which is useful if you have a multicore processor.
it is recommend to use:

	n = number of processors + 1

this may take more than one hour.

#install

tested on Ubuntu `13.04` with kernel dev version `3.10.0-rc5+`

	sudo make modules_install -j5
	sudo make install -j5

this will place:

- the compiled kernel under `/boot/vmlinuz-<version>`

- config file `.config` as `/boot/config-<version>`

- `System.map` under `/boot/System.map-<version>`.

	This contains symbolic debug information.

- `/lib/modules/<version>/` for the modules

now reboot, from the GRUB menu choose "Advanced Ubuntu options",
and then choose the newly installed kernel.

TODO how to go back to the old kernel image by default at startup?
	going again into advance options and clicking on it works,
	but the default is still the newer version which was installed.

TODO how to install the /usr/src/linux-headers- headers?

#test

Tips on how to test with the kernel.

##kernel module

A kernel module can be inserted and removed while the kernel is running,
so it may prevent a time costly rebooting.

However, if you make an error at startup (dereference null pointer for example),
the kernel module may become impossible to reinsert without a reboot.
<http://unix.stackexchange.com/questions/78858/cannot-remove-or-reinsert-kernel-module-after-error-while-inserting-it-without-r/>

Furthermore, if your module messes up bad enough, it could destroy disk data, so be careful.

Consider using a virtual machine instead.

##virtual machine

A virtul machine is a program that emulates another operating system entirely,
including a different on from the host.

You can then simulate running a new kernel inside the virtual machine.

It stores disk data on a separate place from the host data (either in a special file, or in a reserved partition),
so that if kernel modifications would cause disk damage, all you have to do is reinstall things on the virtual machine,
but your computer won't be damaged.

Also, it is faster to reboot the virtual machine than the host system if your module cannot be inserted anymore.

Use a virtual machine that supports directory sharing such as Oracle Virtualbox,
that is, sharing a directory from host into the client.

You can then easily test your kernel moduels on the virtual machine by using a script like the following from the virtual machine:

    UNAME=
    DIRNAME=kernel

    sudo rm -rf $DIRNAME
    sudo cp -r /media/sf_kernel $DIRNAME
    sudo chown -R $UNAME $DIRNAME
    cd $DIRNAME
    make clean
    make run

where:

- `UNAME`:

    username of the user on the virtual machine

- `DIRNAME`:

    Directory name to be used for compilation relative to current dir.

    Its content is removed at every compile, so don't put important stuff in there.

- `/media/sf_kernel`:

    Directory shared between client and host, that corresponds to the host's location of the module code and `Makefile`.

#get kernel version

    uname -r

    cat /proc/version

#sysctl

view/config kernel parameters at runtime

    sudo sysctl –a

#coding conventions

- tabs instead of spaces. Configure editors to view tabs as 8 spcaes. In `vim` you could source:

               if expand('%:e') =~ '\(c\|cpp\|f\)'
                    set noexpandtab
                    set tabstop=8
                    set shiftwidth=8
               endif

     the 8 space rule is needed when we want to make ascii tables and align each column at a multiple of the tab width
     so that it is easier to write the table.

     For example, if a tab has 8 spaces then only one tab is need for:

          123456     c2
          c1          c2
          c1          c2

     but two tabs would be needed for:

          123456789     c2
          c1               c2
          c1               c2

     if the tab was sees as say, 4 spaces, the first example would look ugly:

          123456     c2
          c1     c2
          c1     c2

##double underscores

Functions that start with two underscores are low level functions. This means that:

1. there is probably a more convenient and usually more correct function available.
2. it is more likelly to get deprecated some day.

The message is then clear: avoid using those unless you know exactly what you are doing
and you really need to do it.

##proc filesystem representation

each process has a representation on the file system under `/proc/\d+` which allows useres with enough
priviledge to gather information on them. Sample interesting fields:

- limits: limits to various resources which are imposed by the kernel

    going over those limits may cause the kernel to terminate processes with certain signals

#interruptions

- user space process can be interrupted by anyting, including other user space processes.
- kernel space processes can be interrupted by other kernel processes or interrupts handlers,
    but not by user space processes.

    examples of things that generate kernel space processes:

    - system calls
    - module insertion/removal
    - scheduled kernel processes such as softirqs.

        those are run in kernel threads

- interrupt handlers cannot be interrupted by anyting else, not even other interrupt handlers.

#x86

This section discusses issues specific to the x86 linux implementation.

##exceptions

Intel reserves interrupt numbers from 0 to 31 for exceptions:
anormal execution of instructions such as division by zero,
or accessing forbidden memoyr areas.

Certain interrupt numbers are processor interrupts called exceptions.

Linux deals with those interrupts in interrupt handlers,
and then if a user process generates one of those exceptions,
the process is notified via a predefined signal.

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

#kernel ring buffer

See: dmesg.

#dmesg

Print the system log:

    dmesg

<http://www.web-manual.net/linux-3/the-kernel-ring-buffer-and-dmesg/>

#process virtual address space

How the kernel fits multiple processes, kernel and user, into a single RAM.

##prerequisites

Before reading any of this, *understand paging on a popular architecture* such as x86.
Even better, leran it on a second popular platform such as ARM, which will make it clearer
how the kernel why the kernel chooses certain models that will fit manu platforms.

The kernel uses complicated features of the CPU to manage paging, so if you don't understand
those it will be impossible to understand what is being said here.

Good source on the subject: <http://stackoverflow.com/questions/18431261/how-does-x86-paging-work>.

##sources

Free:

- good beginner's tutorial: <http://duartes.org/gustavo/blog/post/anatomy-of-a-program-in-memory>

- good tutorial: <http://www.bottomupcs.com/virtual_address_and_page_tables.html>

[rutgers-memory]: http://www.cs.rutgers.edu/~pxk/416/notes/09-memory.html

- [Rutgers lecture notes on Memory Management][rutgers-memory]

    Good info on the historical development of virtual adress space techniques.

Non-free:

- bovet - 2005 - Understanding the Linux Kernel. Chapter "Memory Adressing".

    Good info on the x86 memory hardware.

##goals of a virtual memory space

- allow multiple programs to share a single RAM, while having the
    the convenient illusion that their memory is contiguous.

    It would be hard to do this without paging because the memory size of programs
    changes with time and is not predictable.

- protection: control which addresses process can or cannot use.

    For example, processes cannot accesses pages of another process, specially the kernel itself!

    If a page cannot be found in the page table of a process
    then the processes does not have the right to access it.

- swap to disk: allow for programs to use more RAM than is available.

    It suffices to store a flag indicating if memory is on main memory or on disk,
    and if it is on disk then the address indicates the disk address of the page.

- fast process switch.

    Switching the entire processes in memory comes down to
    a single operation of changing the page table in use.

##ancient approaches

In order to understand why virtual memory via paging is good,
it is a good idea to see older solutions to the problem and why they were not good enough.

[This tutorial][rutgers-memory] is a good source of such information.

##hardware support

RAM memory access is one of the most common operations doen by a program.

Therefore if any control is to be done at every single memory operation,
it must be *very* fast. This is why most architectures have some hardware support
for those control operations.

It is then necessary to first understand how those hardware cirquits work.
Architecture specifics shall not be discussed here: look for specific
info on each Architecture.

A good place to start is with x86 paging circuitry.

As usual, Linux adopts a single unified model that covers several architectures.

#virtual memory space for a single process

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

##valid adresses

Valid program accesses:

- RW on: data, BSS, heap, memory mappings and stack
- R on: text

If a process tries to access addresses between TASK_SIZE and RLIMIT_STACK
the kernel may allow its stack to grow.

Any other access attempt will generate a TODO page or seg fault?

##kernel segment

Never changes between processes.

TASK_SIZE is typically 3/4 of the total memory.

Note that this is *virtual* memory, so it is independant of the acutual size of the memory
as the hardware and the kernel can give processes the illusion that they actually have
ammounts of memory larger than the hardware for instance.

##random offset segments

Randomly generated for each proess to avoid attacks.

Must be small not to take too much space.

##stack

Grows down.

May be allowed to increase by the OS access is done before the maximum stack value `RLIMIT_STACK`.

##memory mapping

Created via `mmap` system calls.

Stores dynamically loaded library code.

##heap

Usually managed by language libraries such as C malloc.

Manipulated on the system level by the `brk` syscall.

##BSS

Unitialized variables.

No need to store their value on the binary file,
only need to reserve space for them after startup.

Does not change size.

##data

Initialized variables.

Directly copied from the executable file.

##text

Code to be executed + certain char strings.

Is directly copied from the executable file.

#page

First learn about hardware paging in a common architecture such as x86 family.
This will be not explained here.

Pages are modeled by `struct page` under `mm_types.h`.

Hardware deals in terms of pages to:

- make retrival faster, since the bus clock is much slower than the cpu clock
    and because of memory locality.

- serve as a standard unit for page swap betweem RAM and HD

##page flags

Defined in `page-flags.h`.

##page frame

A page frame refers to the smalles physical memory that the processor can ask
from the RAM.

Paging usually has hardware support today.

##multilevel scheme

Modern systems are preemptive: they can stop tasks to start another ones, and continue with the old task later

A major reason for this is to give users the illusion that
their text editor, compiler and music player can
run at the same time even if they have a single cpu

Scheduling is chooshing which processes will run next

The processes which stopped running is said to have been *preempted*

The main difficulty is that switching between processes (called *context switch*)
has a cost because if requires copying old memory out and putting new memory in.

Balancing this is a question throughput vs latency balace.

- throughput is the total average performance. Constant context switches reduce it because they have a cost
- latency is the time it takes to attend to new matters such as refreshing the screen for the user.
Reducing latency means more context switches which means smaller throughput

#scheduling

Modern systems are preemptive: they can stop tasks to start another ones, and continue with the old task later

A major reason for this is to give users the illusion that
their text editor, compiler and music player can
run at the same time even if they have a single cpu

Scheduling is chooshing which processes will run next

The processes which stopped running is said to have been *preempted*

The main difficulty is that switching between processes (called *context switch*)
has a cost because if requires copying old memory out and putting new memory in.

Balancing this is a question throughput vs latency balace.

- throughput is the total average performance. Constant context switches reduce it because they have a cost
- latency is the time it takes to attend to new matters such as refreshing the screen for the user.
    Reducing latency means more context switches which means smaller throughput

##sleep

- <http://www.linuxjournal.com/node/8144/print>

how to sleep in the kernel

Low level way:

set_current_state(TASK_INTERRUPTIBLE);
schedule();

Higher level way: wait queues.

##state

Processes can be in one of the following states (`task_struct->state` fields)

- running: running. `state = TASK_RUNNING`

- waiting: wants to run, but scheduler let another one run for now

    `state = TASK_RUNNING`, but the scheduler is letting other processes run for the moment.

- sleeping: is waiting for an event before it can run

    `state = TASK_INTERRUPTIBLE` or `TASK_UNINTERRUPTIBLE`.

- stopped: execution purpusifully stopped for exaple by SIGSTOP for debugging

    `state = TASK_STOPPED` or `TASK_TRACED`

- zombie: has been killed but is waiting for parent to call wait on it.

    `state = TASK_ZOMBIE`

- dead: the process has already been waited for,
and is now just waiting for the system to come and free its resources.

    `state = TASK_DEAD`

The following transitions are possible:


    +----------+ +--------+
    |          | |        |
    v          | v        |
    running -> waiting    sleeping
    |                     ^
    |                     |
    +---------------------+
    |
    v
    stopped

##policy

policy is the way of choosing which process will run next

POSIX specifies some policies, Linux implements them and defines new ones

policy in inherited by children processes

###normal vs real time policies

policies can be divided into two classes: normal and real time

real time processes always have higher priority:
whenever a real time process is runnable it runs instead of normal processes
therefore they must be used with much care not to bog the system down

the name real time policy is not very true: Linux does not absolutelly ensure
that process will finish before some deadline.

however, realtime processes are very priviledged,
and in absense of other real time processes without even higher priorities,
the processes will run as fast as the hardware can possibly run it.

##priorities

priorities are a measure of how important processes are,
which defines how much cpu time
they shall get relative to other processes

there are 2 types of priority:

- real time priority

ranges from 0 to 99

only applies to process with a real time scheduling policy

- normal priorities

ranges from -20 to 19

only applies to proces with a normal scheduling policy

also known as *nice value*. The name relates to the fact that higher nice values
mean less priority, so the process is being nice to others and letting them run first.

nice has an exponential meaning: each increase in nice value means that
the relative importance of a process increases in 1.25.

for both of them, lower numbers mean higher priority

internally, both real time and normal priorities are represented on a single
integer which ranges from 0 to 140:

- real time processes are in the 0 - 99 range
- normal processes are in the 100 - 140 range

once again, the lower values correspond to the greater priorities

priority is inherited by children processes

###nice

is the traditional name for normal priority,
ranging from -20 (greater priority) to 19.

an increase in 1 nice level means 10% more cpu power

##normal policies

###completelly fair scheduler

all normal processes are currently dealt with internally by the *completelly fair scheduler* (CFS)

the idea behind this scheduler is imagining a system where there are as many cpu's
as there are processeimagining a system where there are as many cpu's as there are processes

being fair means giving one processor for each processes

what the CFS tries to do is to get as close to that behaviour as possible,
even though the actual number of processors is much smaller.

###normal scheduling policy

represented by the `SCHED_NORMAL` define

###batch scheduling prolicy

represented by the `SCHED_BATCH` define

gets lower priority than normal processes TODO exactly how much lower

###idle scheduling prolicy

the lowest priority possible

processes with this policy only run when the system has absolutely

represented by the `SCHED_IDLE` define

##real time policies

###fifo

represented by the `SCHED_FIFO` define

highes priority possible

handled by the real time scheduler.

the process with highest real time priority runs however much it wants

it can only be interrupted by:

- another real time processes with even higher priority becomes RUNNABLE
- a SIGSTOP
- a sched_yield() call
- a blocking operation such as a pipe read which puts it to sleep

therefore, lots of care must be taken because an infinite loop here
can easily take down the system.

###round robin

represented by the `SCHED_RR` define

processes run fixed ammounts of time proportional to their real time priority

like turning around in a pie where each process has a slice proportional to
it real time priority

can only be preempted like fifo processes, except that it may also be preempted
by other round robin processes

TODO if there is a round robin and a fifo processes, who runs?

##swapper process

when there are no other processes to do,
the scheduler chooses a (TODO dummy?) processes called *swapper process*

##runqueues

a runqueue is a list of processes that will be given cpu time
in order which process will be activated.

it is managed by schedulers, and is a central part of how the scheduler
chooses which process to run next

there is one runqueu per processor.

The linux kernel is written on mainly on c c99 standard,with **gasp** gcc extensions. Therefore the linux kernel is married to gcc.
Just guessing here, but an important reason for that is to use inline assembly TODO check

Also note that besides the linux kernel, what most people call a linux system, or more precisely
a linux distribution, must also contain many more user level basic services such as the python
interpreter, the X server, etc. The extra user space services are specified by the lsb, and are not a part
of the linux kernel.

You cannot use user space libs such as libc to program the kernel,
since the kernel itself itself if need to be working for user space to work.

#examples portability

All code samples were tested on kernel 3.10.

#sources

Linux documentation kind of sucks.

Most function definitions or declarations don't contain any comments,
so you really need to have a book in your hands to understand things.

Therefore, the only way to understand things is to hope to find them on some book,
and if not, interpret source codes, which are possibly very convoluted for performance
and other complex restrictions.

Maybe there is a good reason for that.

##free sources

- `git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git`

    The source code, *the* only definitive source.

    Nany important comment lacking however.

- `make htmldoc`

    Generates documentation for the kernel from comments, and puts it under `Documentation/DocBook/index.html`

    The most useful is under `kernel api`. Still, this is grossly incomplete.

    The documentation seems to be stored in the `.c` files mostly rather than on the `.h`.

    Weirdly the snapshots of htmldoc on kernel.org have some extra functions, check it out:
    <https://www.kernel.org/doc/htmldocs/kernel-api.html>

- <http://vger.kernel.org/vger-lists.html>

    Kernel mailing lists.

    Mostly bleeding edge design decisions.

- <https://www.kernel.org/doc/>

    kernel.org resources list

##payed sources

- <http://www.amazon.com/books/dp/0596005652>

    Bovet - 2005 - Understanding the Linux Kernel.

    Goes into lots of inner working concepts.

    Could have more examples of using the kernel API.

- <http://www.amazon.com/books/dp/0596005652>

    Love - 2006 - Linux kernel devlopement.

    Great intro on the hardware.

- <http://www.amazon.com/books/dp/0596005903>

    Corbet - 200

#kernel source tree

- `arch`: architecture specific code. Ex: `x86`, `sparc`, `arm`.

    `arch/XXX/include/`

    `asm` contains header files which differ from one architecture to another.

    Those files are used on source as `asm/file.h`, and the make process ensures that they
    point to the target compilation architecture.

    During compilation, the Makefile uses the correct architecture includes and definitions.

	`uapi` contains arch dependant stuff that will be exposed to userspace applications: <http://lwn.net/Articles/507794/>

- `include/linux`:

	Almost all important headers.

	TODO what are the other sibling directories?

- `include/asm-generic`:

    TODO what is this?? isn't all that is under `include` supposed to be generic already?
        <http://stackoverflow.com/questions/3247770/what-is-the-linux-2-6-3x-x-include-asm-generic-for>

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

#special files for user space communication

the kernel communicates parameters to user space using special files,
located mainly under `/proc/`, `/sys/` and `/dev/`

you can see the contents of those files with a command line utility such as cat.

interesting files:

- `cat /proc/interrupts`: status of interrupt handlers
- `cat /proc/version`: linux kernel version and other system info. Similar to `uname -a` output.
- `cat /proc/meminfo`: information on RAM memory
- `cat /proc/cpuinfo`: information on cpu
- numeric directories: 1, 2, 3, ...: contain standard directory structures with process info.

    This is why that dir is called `/proc`

TODO where are those documenteded?

#user programs

User programs such as a simple hello world run inside an abstraction called *process* defined by the kernel.

The kernel restricts what user programs can do directly basically to basic processor operations (adding)
and memory operations (setting or getting RAM memory)

User programs can, however, ask the kernel to do certain operations for them via *system calls*.

A simple example is the c `printf` function, which must at some point ask the kernel to print to `stdout`,
probably via the `write` system call.

Another simple example is file io.

##floating point

you cannto use floating point operations on kernel code because that would incur too much overhead
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

##find definitions

Ways to find info:

- ctags

Try to find the definition of struct `s`:

    ack '^struct s \{'

##usr/include/linux vs usr/src/linux-headers

http://stackoverflow.com/questions/9094237/whats-the-difference-between-usr-include-linux-and-the-include-folder-in-linux

- `/usr/include/linux` is owned by libc on linux, and used to call kernel services from userspace.
	TODO understand with a sample usage

- `/usr/src/linux-headers-$(uname -r)/include/linux/` is exactly part of the kernel tree under `include`
	for a given kernel version.

	can be used to offer access to the kernel's inner workings

	it is useful for example for people writting kernel modules,
	and is automatically included by the standard module `Makefile`.

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

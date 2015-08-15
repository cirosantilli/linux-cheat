# Makefile

How to compile and install the kernel.

To get up and running really fast, use <https://github.com/cirosantilli/runlinux>

Tested on `v4.0`.

Quickstart:

	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	cd linux
    export KBUILD_OUTPUT="$(pwd)/../build"
	make mrproper
	make defconfig
	make -j5
    # Creates the .config file on the build directory.
    # TODO run it somehow on a VM easily.
    # TODO change install path.
    # Current method fails because it needs sudo: `installkernel` would set it up anyways.
    # http://unix.stackexchange.com/questions/5423/how-to-change-the-install-path-of-my-linux-source-tree
    #mkdir "$(pwd)/../install"
    #make install INSTALL_PATH="$(pwd)/../install"
	make modules_install INSTALL_MOD_PATH=../modules
    make headers_install INSTALL_HDR_PATH=../headers
	make firmware_install INSTALL_MOD_PATH=../firmware
    # TODO install path
    #make installmandocs

Documented at: `Documentation/kbuild/`

## KBUILD_OUTPUT

`KBUILD_OUTPUT` can be replaced with `O=../build`, but you have to pass it on all.

One disadvantage of `KBUILD_OUTPUT` is that files like `tags` which should be on the source tree will be put on the build directory, so you have to run:

    (unset KBUILD_OUTPUT make tags)

---

In-tree build is supported, but out-of-tree is likely better, as it

- makes it clear what files are generated and what are part of the source
- allows you to build with multiple configurations

## Verbose

    make V=1

shows all commands that are run.

    make SHELL='sh -x'

is even more verbose.

## Run

After `make install`:

- reboot
- pray that your distro is compatible with the version and configuration you chose (networking failed on Ubuntu 14.04 with a simple `defconfig`)
- run `uname -a` on a terminal and behold your new kernel version

## Help

Get some help on the main targets:

    make help

## Clean

Do a basic clean:

    make clean

Clean everything, including generated configuration:

	make mrproper

This is likely a reference to <https://en.wikipedia.org/wiki/Mr._Clean> in German (and Finnish?)...

## Configuration

Many targets under `make help`.

Those targets generate the `.config` file, which is then used by the `Makefile` to build.

The options are determined by the `Kconfig` files present throughout the kernel.

There seems to be no way to configure the kernel non-interactively except careful grepping: <http://stackoverflow.com/questions/7505164/how-do-you-non-interactively-turn-on-features-in-a-linux-kernel-config-file>

The source for the REPL configuration generators called by make is at `scripts/kconfig/conf.c`.

### defconfig

Simple default configuration:

	make defconfing

### oldconfig

<http://stackoverflow.com/questions/4178526/what-does-make-oldconfig-do-exactly-in-the-linux-kernel-makefile/31936064#31936064>

### olddefconfig

<http://serverfault.com/questions/116299/automatically-answer-defaults-when-doing-make-oldconfig-on-a-kernel-tree>

Like `oldconfig` but default everything that would be asked.

### silentoldconfig

TODO: vs olddefconfig? Less automatic.

### nconfig

### menuconfig

Open up a ncurses interface:

	make menuconfig

that allows you to turn options on or off.

Advantages over direct `.config` editing:

- see the configurations as a logical tree
- you cannot make enter invalid values

Then use the `left` arrow key and choose `Save` on the bottom to save to the `.config` file and then exit.

Navigation:

- `y` or `n`: set or unset current option
- `<Enter>`: enter sub-directory
- `<Esc><Esc>` (double Esc) goes up on the configuration tree. Same as left navigating to "Exit".
- `/`: search for configuration parameter containing a given string
- `?`: show the help for the current item

### tinyconfig

So tiny that Minimal Linux Live won't work.

TODO what is this good for then?

### /boot/config

### List build configuration of installed kernel

<http://superuser.com/questions/287371/obtain-kernel-config-from-currently-running-linux-system>

    cat /boot/config-`uname -r`

or some variant.

This is exactly the `.config` that was used to build the kernel.

If the kernel was compiled with `CONFIG_IKCONFIG`, then you can `cat /proc/config.zg | gunzip`. This off by default on Ubuntu 14.04.

## Build

Build:

	make -j5

this may take more than one hour.

By default, this runs the following targets:

- `vmlinux`, which generates `vmlinux`, the compiled kernel
- `bzImage` which generates `arch/x86/boot/bzImage`
- `modules`

### Compiler choice

The compiler is chosen by the value of the default set value `CC` which is `cc`, which on Ubuntu 14.04 is a symlink to `gcc`.

    ifneq ($(CC),)
    ifeq ($(shell $(CC) -v 2>&1 | grep -c "clang version"), 1)
    COMPILER := clang
    else
    COMPILER := gcc
    endif
    export COMPILER
    endif

### Compile messages

<http://stackoverflow.com/questions/11697800/what-are-the-codes-such-as-cc-ld-and-ccm-output-when-compiling-the-linux-kern>

<http://unix.stackexchange.com/questions/199060/what-do-the-terms-cc-ld-and-shipped-refer-to-during-the-kernel-source-compilati>

## Install

Once you have compiled the kernel, there is one important component missing: the root filesystem that the kernel will use, for example to store `/proc` and `/sys` files.

The kernel is not able to generate that filesystem for you.

### Standard deployment

Install kernel on current machine:

	sudo make install
	sudo make modules_install

Now reboot, from the GRUB menu choose "Advanced Ubuntu options", and then choose the newly installed kernel.

TODO how to go back to the old kernel image by default at startup? Going again into advance options and clicking on it works, but the default is still the newer version which was installed.

TODO what needs to be done so that GRUB sees it?

This method is too slow for development, and you will want to use some kind of virtualization instead like QEMU.

`make install`, forwards to the `installkernel` script, which is not a part of the kernel tree but rather distro supplied. In Ubuntu 14.04 is at `/sbin/installkernel` and furnished by the `debianutils` package. It is a small shell script.

### Installed files

<http://unix.stackexchange.com/questions/5518/what-is-the-difference-between-the-following-kernel-makefile-terms-vmlinux-vml>

- `/boot/initrd.img-<version>`

#### vmlinuz

`/boot/vmlinuz-<version>` from the built `vmlinux`. TODO how is it generated exactly?

#### System.map

`/boot/System.map-<version>` from  `System.map`

This contains symbolic debug information.

TODO understand precisely.

### modules_install

Install modules under `/lib/modules/<version>/` for the modules

Can be configured with:

    make O=../build modules_install INSTALL_MOD_PATH=../modules

Make sure to point to the `../build` so that `.config` is seen

### ISO build

For x86 (why only x86), you can generate a bootable ISO with:

    make isoimage FDINITRD=rootfs.cpio.gz

where `FINITRD` points to a previously constructed `initrd` that will be used to initialize the system.

This method is used by [Minimal Linux Live](https://github.com/ivandavidov/minimal).

The output file generated is:

    build/arch/x86/boot/image.iso

You can then feed the generated ISO directly to QEMU:

    qemu-system-x86_64 -cdrom image.iso

### Headers install

### headers_install

Install Linux headers:

    make headers_install INSTALL_HDR_PATH=../install/headers

Those are only needed for people doing C development with Linux.

They contain mostly:

- `struct` and other data descriptors
- and very small inline functions macros to manipulate data

which are used to interact with Linux user interfaces: system calls and virtual filesystems like sysfs.

glibc C requires those headers, as it must make many system calls.

Most programs will not depend on those headers, and will use glibc as an OS portable wrapper instead.

Documented at: <https://www.kernel.org/doc/Documentation/kbuild/headers_install.txt> which says that:

    Kernel headers are backwards compatible, but not forwards compatible.

Those files are basically a copy paste from `uapi` directories:

- `include/uapi` for the generic ones
- `arch/x86/include/uapi` for the arch specific ones, which end up under `include/asm`

#### /usr/include/linux

    make headers_install INSTALL_HDR_PATH=../headers

`linux-headers-$(uname -r)` package on Ubuntu.

Useful for example for people writing kernel modules, and is automatically included by the standard module `Makefile`.

TODO should be used for userland as well? Given the backwards compatibility quote from the docs, I think yes as long as your installed kernel is newer.

TODO how to generate them? Why are those completely different than my `make headers_install`?

#### /usr/src/linux-headers

TODO vs `/usr/include/linux`: <http://stackoverflow.com/questions/9094237/whats-the-difference-between-usr-include-linux-and-the-include-folder-in-linux>

`/usr/include/linux` is owned by libc on Linux, and used to call kernel services from userspace.

`linux-libc-dev` package in Ubuntu.

## Develop

### cscope

### tags

    make cscope
    make tags

Seems to use `scripts/tags.sh`.

Advantages over a manual call:

- only considers the currently configured arch

### Test

- <http://stackoverflow.com/questions/3177338/how-is-linux-kernel-tested/30367968#30367968>

### Virtualization install

Consider:

- QEMU

## Documentation

### mandocs

Generate manpages from function comments! Yay, docs!

    /**
     *  write_zsctrl - Write to a Z8530 control register
     *  @c: The Z8530 channel
     *  @val: Value to write
     *
     *  Write directly to the control register on the Z8530
     */

    static inline void write_zsctrl(struct z8530_channel *c, u8 val)

TODO what is the format?

## Kbuild

Name of the kernel build system.

Also used outside of the kernel by BusyBox: <http://git.busybox.net/busybox/>

A minimal example: https://github.com/masahir0y/kbuild_skeleton

CMake and even Autotools are likely to be saner choices. TODO: why would someone use Kbuild outside of the kernel?

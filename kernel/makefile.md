# Makefile

How to compile and install the kernel.

Tested on `v4.0`.

Quickstart:

	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	cd linux
	make mrproper
	make defconfig
	make -j5
    # TODO run it somehow on a VM easily.
	sudo make install
	sudo make modules_install

Then:

- reboot
- pray that your distro is compatible with the version and configuration you chose (networking failed on Ubuntu 14.04)
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

### defconfig

Simple default configuration:

	make defconfing

### menuconfig

Open up a ncurses interface:

	make menuconfig

that allows you to turn options on or off.

Advantages over direct `.config` editing:

- see the configurations as a logical tree
- you cannot make enter invalid values

Then go on to `save` to save to the `.config` file and then exit.

Not well explained navigation:

- `<Esc><Esc>` (double Esc) goes up on the configuration tree

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

### Out of tree build

    mv linux build
    mkdir build
    cd src
    # Creates the .config file on the build directory.
    make defconfig O=../build
    make O=../build

In-tree build is supported, but out-of-tree is likely better, as it

- makes it clear what files are generated and what are part of the source
- allows you to build with multiple configurations

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

    make isoimage FDINITRD=../../rootfs.cpio.gz

This method is used by [Minimal Linux Live](https://github.com/ivandavidov/minimal). You can then feed the generated ISO into QEMU.

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

### tags

    make tags

Seems to use `scripts/tags.sh`, which can use a variety of implementations e.g. `ctags`, `cscope`.

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

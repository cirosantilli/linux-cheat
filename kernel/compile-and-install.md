# Compile and install

How to compile and install the kernel.

Get the source:

	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Get some help on the main targets:

    make help

Do a basic clean:

    make clean

Clean everything, including generated configuration:

	make mrproper

This is likely a reference to <https://en.wikipedia.org/wiki/Mr._Clean> in German (and Finnish?)...

Generate the `.config` file:

	make menuconfig
	make xconfig

This opens up a ncurses interface which allows you to choose amongst tons of options (~6k) which determine which features your kernel will include or not.

Then go on to `save` to save to the `.config` file and then exit.

Many of the options of the configuration file can be accessed via preprocessor macros which control system behavior (TODO all of them are accessible?)

For example:

    CONFIG_SMP=y

Means that symmetrical multiprocessing is on (yes), and then in the code we can use:

    #ifdef CONFIG_SMP
        //smp specific
    #endif

Build:

	make -j5

`-j` tells make to spawn several process, which is useful if you have a multi-core processor. It is recommend to use:

	n = number of processors + 1

this may take more than one hour.

## Install

Once you have compiled the kernel, there is one important component missing: the root filesystem that the kernel will use, for example to store `/proc` and `/sys` files.

The kernel is not able to generate that filesystem for you.

### Standard deployment

This method is too slow for development, and you will want to use some kind of virtualization instead.

Tested on Ubuntu 13.04 with kernel dev version `3.10.0-rc5+`

	sudo make modules_install -j5
	sudo make install -j5

This will place:

-   the compiled kernel under `/boot/vmlinuz-<version>`

-   `System.map` under `/boot/System.map-<version>`.

	This contains symbolic debug information.

-   `/lib/modules/<version>/` for the modules

Now reboot, from the GRUB menu choose "Advanced Ubuntu options", and then choose the newly installed kernel.

TODO how to go back to the old kernel image by default at startup? Going again into advance options and clicking on it works, but the default is still the newer version which was installed.

TODO how to install the `/usr/src/linux-headers- headers`?

#### Kernel configuration

#### /boot/config

#### List kernel build configuration

<http://superuser.com/questions/287371/obtain-kernel-config-from-currently-running-linux-system>

    cat /boot/config-`uname -r`

or some variant.

This is exactly the `.config` that was used to build the kernel.

If the kernel was compiled with `CONFIG_IKCONFIG`, then you can `cat /proc/config.zg | gunzip`

### ISO build

For x86 (why only x86), you can generate a bootable ISO with:

    make isoimage FDINITRD=../../rootfs.cpio.gz

This method is used by [Minimal Linux Live](https://github.com/ivandavidov/minimal). You can then feed the generated ISO into QEMU.

## tags

    make tags

Seems to use `scripts/tags.sh`, which can use a variety of implementations e.g. `ctags`, `cscope`.

Advantages over a manual call:

- only considers the currently configured arch

## compiler choice

On 4.0, the compiler is chosen by the value of the default set value `CC` which is `cc`, which on Ubuntu 14.04 is a symlink to `gcc`.

    ifneq ($(CC),)
    ifeq ($(shell $(CC) -v 2>&1 | grep -c "clang version"), 1)
    COMPILER := clang
    else
    COMPILER := gcc
    endif
    export COMPILER
    endif

# Compile and install

How to compile and install the kernel.

Get the source:

	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Clean everything:

	make mrproper

Generate the `.config` file:

	make menuconfig

This opens up a ncurses interface which allows you to choose amongst tons of options which determine which features your kernel will include or not.

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

`-j` tells make to spawn several process, which is useful if you have a multicore processor. It is recommend to use:

	n = number of processors + 1

this may take more than one hour.

## Install

Tested on Ubuntu 13.04 with kernel dev version `3.10.0-rc5+`

	sudo make modules_install -j5
	sudo make install -j5

This will place:

-   the compiled kernel under `/boot/vmlinuz-<version>`

-   config file `.config` as `/boot/config-<version>`

-   `System.map` under `/boot/System.map-<version>`.

	This contains symbolic debug information.

-   `/lib/modules/<version>/` for the modules

Now reboot, from the GRUB menu choose "Advanced Ubuntu options", and then choose the newly installed kernel.

TODO how to go back to the old kernel image by default at startup? Going again into advance options and clicking on it works, but the default is still the newer version which was installed.

TODO how to install the `/usr/src/linux-headers- headers`?

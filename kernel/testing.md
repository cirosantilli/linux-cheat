# Testing

Tips on how to test with the kernel.

## Official testing methods

<http://stackoverflow.com/questions/3177338/how-is-linux-kernel-tested>

None. Not even unit tests.

Third party projects:

- <https://github.com/linux-test-project/ltp>

## Kernel module

A kernel module can be inserted and removed while the kernel is running, so it may prevent a time costly rebooting.

However, if you make an error at startup (dereference null pointer for example), the kernel module may become impossible to reinsert without a reboot. <http://unix.stackexchange.com/questions/78858/cannot-remove-or-reinsert-kernel-module-after-error-while-inserting-it-without-r/>

Furthermore, if your module messes up bad enough, it could destroy disk data, so be careful.

Consider using a virtual machine instead.

## Virtual machine

The best way to tests a fully blown kernel modification in full security.

Get your hands on Oracle VirtualBox and shoot away.

You can then easily test your kernel modules on the virtual machine by using a script like the following from the virtual machine:

    UNAME=
    DIRNAME=kernel

    sudo rm -rf $DIRNAME
    sudo cp -r /media/sf_kernel $DIRNAME
    sudo chown -R $UNAME $DIRNAME
    cd $DIRNAME
    make clean
    make run

Where:

-   `UNAME`:

    Username of the user on the virtual machine.

-   `DIRNAME`:

    Directory name to be used for compilation relative to current dir.

    Its content is removed at every compile, so don't put important stuff in there.

-   `/media/sf_kernel`:

    Directory shared between client and host, that corresponds to the host's location of the module code and `Makefile`.


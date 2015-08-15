# BusyBox

Single executable that includes all POSIX command line utilities, including `sh`, and no libc dependency.

The logo "The Swiss Army Knife of Embedded Linux" does it great justice: it is small and has many utilities, just like a swiss knife.

Popular for minimal distributions, e.g. <https://github.com/ivandavidov/minimal>

Quickstart:

    git clone git://git.busybox.net/busybox
    make defconfig
    make
    make install

This generates a single `busybox` 2Mb executable. It is common to configure it to embed libc so it will work in systems without it. TODO how

It is also possible to configure exactly which utilities will be present on the output.

You can use it either with subcommands:

    ./busybox echo a

or with symlinks, which is the standard approach when deploying it:

    ln -s busybox echo
    ./echo a

`busybox` uses `argv[0]` to decide the executable in this case.

`make` install generates an `_install` directory with all utilities symlinked to `busybox`.

## init

BusyBox also implements a version `init`, which is capable of reading `/etc/inittab` to startup the system.

Even though Ubuntu 14.04 does not have it installed by default, its boot system adds it to the `/boot/initrd*` files. Poetically speaking, the initial boot environment has characteristics of an embedded system.

It is then the job of `init` to mount

## Internals

BusyBox uses the kernel's Kconfig mechanism.

In particular, it is affected by variables like `KBUILD_OUTPUT` just like the kernel, and has identical targets like `defconfig` and `mrproper`.

Unlike the kernel, the `KBUILD_OUTPUT` directory must exist before running `make`... Why?

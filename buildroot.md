# Buildroot

Run two commands, get a Linux distro built from source.

1.  Examples
    1. [Add a new package in tree](https://github.com/cirosantilli/buildroot/tree/in-tree-package-2016.05)
    1. [Package with a Kernel module in tree](https://github.com/cirosantilli/buildroot/tree/kernel-module-2016.05)
    1. [Out of tree package](https://github.com/cirosantilli/buildroot/tree/out-of-tree-2016.05)

## Introduction

Takes care of:

- cross compilation. In other words, compiles GCC for you. Several archs supported.
- bootloading. Several bootloaders supported.
- root filesystem generation.
- tons of packages, e.g. X.org. Packages have a dependency system, but no versioning.

Lots of software supported.

## QEMU example

Tested on Ubuntu 16.04.

    git clone git://git.buildroot.net/buildroot
    cd buildroot
    git checkout 2016.05
    make qemu_x86_64_defconfig
    # Can't use -jN, use `BR2_JLEVEL=2` instead.
    make BR2_JLEVEL=2
    # Wait.
    # cat board/qemu/x86_64/readme.txt
    qemu-system-x86_64 -M pc -kernel output/images/bzImage -drive file=output/images/rootfs.ext2,if=virtio,format=raw -append root=/dev/vda -net nic,model=virtio -net user

## ARM

The obvious x86 analog just works, beauty.

The only thing is that you have to move the x86 output away if you have one:

    mv output output.x86~
    make qemu_arm_versatile_defconfig
    make
    qemu-system-arm -M versatilepb -kernel output/images/zImage -dtb output/images/versatile-pb.dtb -drive file=output/images/rootfs.ext2,if=scsi,format=raw -append "root=/dev/sda console=ttyAMA0,115200" -serial stdio -net nic,model=rtl8139 -net user

Then in QEMU:

    cat /proc/cpuinfo

## Don't ask for password at login

<http://unix.stackexchange.com/questions/299408/how-to-login-automatically-without-typing-root-in-buildroot-x86-64-qemu>

## config

All options are stored in `.config` before build. The `.config` file fully specifies the entire system.

Make and environment variables *don't* in general override options:

    # Does not work.
    #make defconfig BR2_SOME_OPT=y

Whenever you do `make`, `make oldconfig` gets run. `make oldconfig` removes any new options you've added to the file, unless they are specified under `package/Config.in`.

Some configs are not put on the `.config`, while others are commented out. TODO: commented out means dependencies and have been met, removed not?

### Important configurations

    LINUX_KERNEL_VERSION="4.5.3"
    BR2_GCC_VERSION_4_9_X=y

## Add a file to the distro

    mkdir a
    mkdir a/b
    date >a/b/c
    make BR2_ROOTFS_OVERLAY='a'

Outcome: the root of the generated filesystem now contains `/b/c`.

## Permanent storage filesystem

TODO

## Remove package

Currently impossible.

For simple cases, just remove the files from:

    rm output/target/usr/bin/hello

## random: nonblocking pool is initialized

TODO how to stop printing that

## Projects that use Buildroot:

- <https://en.wikipedia.org/wiki/OpenWrt>

## Games

Placed under `/usr/bin` and `/usr/games`.

Grouped under `packages/Config.in`:

    menu "Games"

Many / all are SDL based. It seems that SDL has an `fbdev` mode that dispenses X11.

### prdoom

### chocolate-doom

Doom clones.

This shows one running on uclinux blackfin SDL DirectFB: https://www.youtube.com/watch?v=fKyQOntPEFs

### ltris

### lbreakout2

From: http://lgames.sourceforge.net/about.php

Simple SDL based games `L` stands for Linux.

Should be able to run on framebuffer? But both on TTY and X11 they fail with:

    set_video_mode: cannot allocate screen: Couldn't set console screen info

Looks like this is caused by the call: <https://www.libsdl.org/release/SDL-1.2.15/docs/html/sdlsetvideomode.html>

`fbset` seems to do the same calls, and fails in the same way.

### opentyrian

Takes over screen and hangs.

### sl

Classic steam locomotive `sl` typo corrector. Text only.

### gnuchess

CLI chess.

## X11

http://unix.stackexchange.com/questions/70931/install-x11-on-my-own-linux-system

## GUI

- <http://unix.stackexchange.com/questions/70931/install-x11-on-my-own-linux-system/306116#306116>

## SDL without X11

- <http://stackoverflow.com/questions/1263710/minimal-linux-distrobution-with-sdl-support-and-no-xwindows>

## Web browser

- <http://unix.stackexchange.com/questions/17779/how-can-i-build-a-custom-distribution-for-running-a-simple-web-browser/306192#306192>

## Debugging tools

The basics: always compile with:

- debugging symbols
- gdb and gdbserver on target
- host cross gdb
- strace

## sshd

<http://stackoverflow.com/a/39301480/895245>

## nc

## netcat

Not enabled on BusyBox by default, see: `package/busybox/default.config`

But we have ping (TODO from where?), so whatever.

## Boards

### Raspberry pi

TODO: how to emulate with QEMU? `aarch` procedure did no work, no `dtb` file.

Just worked on a PI2 via UART. No `sshd` daemon though.

### Firefly

- <https://bugs.busybox.net/show_bug.cgi?id=9226>
- <http://bbs.t-firefly.com/forum.php?mod=viewthread&tid=1777>

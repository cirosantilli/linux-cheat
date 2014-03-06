Info and cheatsheets on utils that work on Linux (and possibly other OSs too) and Linux internals.

Most useful files:

- [utils.sh](utils.sh): main dump for utils that fit in no other category such as POSIX utilities.
- [ubuntu-install.sh](ubuntu-install.sh): software selection and install methods for Ubuntu. No tutorials.

#Definition: utils

By *utils* we mean:

- programs
- programming languages
- libraries

either in the LSB or not.

#Other OS

Many of those tools may be cross platform or have very similar ports for other OSs so the info here is also useful for other OS. I have not however tested anything in any OS except Linux.

#This is the default utils repo

Those utils are kept in this repo because they don't deserve a repo of their own because there is not enough info written on them.

The choice of Linux and not other OS is because and because Linux is the best open source OS today.

#How to search for stuff

For filenames:

    find . -iname '*something*'

And for inner sections:

    git grep '#something'
    git grep '##something'

`#` and `##` for files in which `#` indicates a comment are consistently used as a keyword identifier.

#Introduction

Linux in informal terms can be either a computer system that:

- a computer system which complies to the [linux standar base (LSB)](lsb)
    which is the main standard maintained by the [Linux foundation][]

- uses the Linux kernel. TODO is this specified by the LSB? where? <http://unix.stackexchange.com/questions/75611/what-does-the-linux-standard-base-specify-about-the-kernel>

The LSB specifies the minimum interfaces every Linux system must offer.

The central component of the Linux operating system is the Linux kernel, released in 1991 by Linus Trovalds, however much of its core user space software comes from the GNU project. For this reason Linux systems may also be called GNU/Linux.

#sources

- `git clone http://git.kernel.org/pub/scm/docs/man-pages/man-pages`

    The Linux man pages, documenting the kernel and C interfaces to it.

    In special, look under

    - `Documentation/` for docs
    - `include/linux` for stuff you may use from modules

- info

    GNU project substitude for man.

    Usually much longer explanations and examples.

    Better nodewise navigation.

- the geek stuff

   <http://www.thegeekstuff.com>

   Short tutorials with lots of examples.

- <http://www.linuxfromscratch.org/>

    Linux from scratch.

    Teaches how to build a minimal linux distro from base standard packages.

- <https://wiki.archlinux.org/index.php/Installation_Guide>

    Arch Linux installation guide.

    Since Arch Linux is very minimalistic, installing it can teach you a lot.

    Like LFS but you start at a higher level already.

- <http://www.cavecanen.org/linux/humour/horrorstories.txt>

    Real *NIX sysadmin horror stories of things gone terribly wrong.

#distributions

A Linux distribution is a LSB compliant system.

Typically, distributions contain end user applications such as text editors of music players, making it usable out of the box for a large variety of non programmer users.

This work is left for third party enterprises of community projects such as Ubuntu or Fedora which are maintained by Canonical and Red Had enterprises respectively.

LSB is meant to contain all the core tools that allow compliant applications to be portable across any compliant distribution.

LSB does however specifies many more tools than POSIX and supports almost all base tools used by user friendly applications found in distributions.

##lsb_release

Command required by the LSB.

Get distro maintainer, name, version and version codename:

    lsb_release -a

Extract id programmatically to autodetect distro:

    distro="$(lsb_release -i | sed -r 's/.*:\t(.*)/\1/')"

##install a new distro

Most distros are distributed in ISOs suitable to burning on a CD or DVD, from which you can then boot the computer and install them.

It is also possible to put the CD or DVD image in a USB.

Such CDs or USBs are commonly called Live.

You can keep in mind that booting from a Live CD means that that CD contains at least the Kernel image so that you load that image into RAM instead of loading it from your HD.

If you are on a read only CD however, you can usually not save any information to the CD while on a live boot, so it makes no sense to save a file to the CD.

You could however mount your hard disk, and write to it after you booted from the CD.

You will need a free partition for the installation.

###usb install

Some distros offer a Windows method of USB installation which does not destroy USB data completely.

Some installers even allow you to reserve space on the USB for permanent storage, so that you can use your OS from the USB just as if it were an small and fast HD.

If however you are already on Linux, you will probably have to destroy all USB information, because the ISO image has to be the very first thing on your USB, therefore erasing essential filesystem structures such as the main boot record partition table of the USB.

Of course, you can always recreate a filesystem in your USB and use it as a storage device once you are done with it.

First find the device for the USB which we will call `/dev/sdX` with:

    sudo lsblk -f

The USB must not be mounted (`lsblk` shows no mountpoint). You can unmount it with:

    sudo umount /path/to/montpoint

To install the image on the USB do:

    sudo dd bs=4M if=/path/to/iso.iso of=/dev/sdX

Where `/dev/sdX` is the mount point of the USB.

This will erase all data on the USB!

*Don't* write to the first partition `/dev/sdX1`, since what we want is to write to the start of the device, not to the start of its first partition!

###bootloader problems

Most distributions install their own bootloader, meaning that they rewrite the existing bootloader.

This means that if the new bootloader cannot recognize certain types of boot data on each partition, you will not see those partitions as bootable.

This is for example the case if you install a distro with GRUB 2 (Ubuntu 13.04), and then install another distro which uses GRUB (Fedora 17)

GRUB cannot recognize GRUB 2 booting data since it came before GRUB 2 existed, so you will not see your old bootable partitions as bootable.

Therefore, if you have the choice, the best option in this case would be to first install the GRUB distro, and only then the GRUB 2 distro, so that in the end you will have GRUB 2, which will see both partitions as bootable.

This can be corrected in 2 ways: from a live boot, or from an existing partition with GRUB 2.

####live boot

If you can Live boot in the distro that uses GRUB 2 things are easy.

Boot with the Live CD, and then simply reinstall the GRUB 2 bootloader, using the GRUB 2 installer that comes with the Live CD, so that on next system start GRUB 2 will be used, and will recognize both GRUB and GRUB 2 partitions.

All that is needed to do this is to issue:

    sudo grub-install --root-directory=/media/grub2/system/mount/point /dev/sdX

Where:

- /media/grub2/system/mount/point

    Mountpoint for you GRUB 2 system.

    You must have mounted it with `mount` before.

    Some distros like Ubuntu's Live CD already mount all possible systems, so you might not need to mount it.

    If that is the case, you can check where you partition is mounted with `sudo mount -l`, and then looking into partitions that have the correct type and listing the files inside candidates to make sure that it is the correct partition.

- /dev/sdX

    Device file for the Hard disk you want to install GRUB on.

    Remember that GRUB bootloader is installed at the very start of the entire HD, and not of some partition, so it makes no sense to give a partition device such as `/dev/sda1` or `/dev/sda2`.

Source: <http://askubuntu.com/questions/59359/unable-to-boot-into-ubuntu-after-ubuntu-fedora-dual-boot/59376#59376>

####existing GRUB2 partitions

If you do not have access to a Live CD, you can mount the GRUB 2 partition,
and `chroot` into it, and then reinstall GRUB 2.

It will be just as if you were issuing that command from that partition.

Procedure: <http://askubuntu.com/questions/88384/how-can-i-repair-grub-how-to-get-ubuntu-back-after-installing-windows>

---

Keep in mind that what GRUB does is simply read its configuration files, and after interpreting those write data to specific points of the HD (Master boot record, at the very beginning of the HD) instructions on how to boot.

#certification

The Linux foundation offers certification and compliance verification tools for distribution developers and application developers.

The list of certified distributions and products can be found here: <https://www.linuxbase.org/lsb-cert/productdir.php?by_lsb.>

Notable certified systems include:

- Ubuntu 9.4

    However not later versions up to time of writting

    [It seems that](http://askubuntu.com/questions/89125/does-ubuntu-follow-the-linux-standard-base-lsb)
    Ubuntu does not intend to fully comply
    on certain specific points, but only be highly compliant

- Red Hat Enterprise Linux 6.0

#gnu

The user space programs of most Linux distributions are mostly inherited from the *GNU project*
which was created in 1983 by Richard Stallman.

For example, the following central components originate from GNU:

- GCC
- glibc
- bash

It seems that the GNU project is not officially called like that anymore, and has transformed into the *free software foundation* (FSF) also founded by Stallman. TODO check

Amongst the projects of the FSF is the *gnu operating system*. they are also active in legal causes and activism for free software.

The GNU operating system is developing its own kernel called *HUD*, but the own project states that it is not yet ready for broad usage

The FSF insists on calling what most people call Linux as GNU/Linux, which sounds quite reasonable considering they developed a great part of the userspace core.

The GNU software foundation is the creator and current maintainer of the GPL license, and mostly uses that license for its software and is the main enforcer of its infringements.

##gnu alternatives

Some notable alternatives to the GNU tools:

#POSIX

LSB is already highly POSIX compliant, and it states that it is on of its long term goals meant to become fully POSIX compatible

Incompatibilities are being listed for future resolution.

There a few POSIX requirements that the Linux kernel explicitly does not implement because it considers them impossible to implement efficiently.

#FHS

The filesystem hierarchy standard specifies base directories for the system and what should go in them.

It is also maintained by the Linux foundation, and followed by the LSB.

##de facto but not mentioned in fhs

- `/etc/alternatives`

    Contains symlinks that determine default programs.

    For example: `editor -> /usr/bin/vim` and so on.

    Can be updated via `man update-alternatives`.

    Some important ones are:

    - editor: text editor
    - x-www-browser: text editor

#lsb

##core

- elf filetype
- rpm is the default packaging format! The package is not specified
- users and groups
- system initialization
- libc: C standard libraries shared object
- libm: C math library shared object
- libncurses: for command line interfaces

##c++

- C standard library shared objects are required

##interpreted languages

- Python
- Perl

##desktop

- OpenGL shared objects
- X11, GTK+, Qt runtimes
- JPEG, PNG shared object libraries
- ALSA (sound)

#basename conventions

Not in the FHS, but often used.

###^\.

Hidden files.

It is up to programs to decide how to treat them.

###\.~$

Backup file.

###\.bak$

Backup file.

###\.orig$

Original installation file.

###\.d$

Many theories, a plausible one: differentiate `a.conf file` from `a.conf.d` dir normally, all files in the `a.conf.d` dir will be sourced as if they are inside `a.conf`.

#signals

Signals are an ANSI C concept, with extensions by POSIX and Linux.

Aspects which are defined to ANSI C or POSIX shall not be covered here.

Get a list of all signals the system supports:

    kill -l

[lsb]: http://www.linuxfoundation.org/collaborate/workgroups/lsb/download
[linux foundation]: http://www.linuxfoundation.org/

#timestamps

TODO check what is POSIX and what is not.

All of the timestamps can be retreived via a `sys_stat`,
or via a `stat` shell call.

There are 3 widely supported timestamps (POSIX?)

- atime
- mtime
- ctime

And one timestamp with very little current support:

- btime

##atime

Access time.

Last time file or was accessed, for example via a `sys_read` or `sys_execve` or `sys_readdir`.

`sys_stat` does not change this date.

Examples:

`sys_read` updates atime:

    echo a > a
    stat a
    sleep 1
    cat a
    stat a

`sys_execve` updates atime:

    echo 'echo a' > a
    stat a
    sleep 1
    ./a
    stat a

`sys_readdir` updates atime of directories:

    mkdir d
    stat d
    sleep 1
    ls d
    stat d

##mtime

Modification time.

Last time the file or directory data was modified, for example via a `sys_write` call or file creation in the directory.

Those system calls do no modify the atime.

Those system calls also modify the ctime.

Metadata such as permissions and ownership are not considered.

Writing the same data twice updates mtime:

    echo a > a
    stat a
    echo a > a
    stat a

File creation updates mtime of directories:

    mkdir d
    stat d
    sleep 1
    touch d/a
    stat d
        #mtime updated

`sys_unlink` updates mtime of directories:

    mkdir d
    stat d
    touch d/a
    sleep 1
    rm d/a
    stat d
        #mtime updated

Only top level directory changes are considered, since only those are stored in the directory data:

    mkdir d
    mkdir d/d
    stat d
    sleep 1
    touch d/d/a
    stat d
        #mtime unchanged

##ctime

Change time.

Last time inode information was changed, for example permissions, owner, group.

Example:

    echo a > a
    stat a
    sleep 1
    chmod 777 a
    stat a
        #ctime changed
        #mtime same

##btime

Birth time.

Time of original creation of the file, not considering modifications.

    echo a > a
    stat a
    chmod 777 a
    stat a

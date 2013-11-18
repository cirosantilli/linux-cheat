linux in informal terms can be either a computer system that:

- a computer system which complies to the [linux standar base (lsb)](lsb)
    which is the main standard maintained by the [linux foundation][]

- uses the linux kernel. TODO is this specified by the lsb? where?

the lsb specifies the minimum intefaces every linux system must offer.

the central component of the linux operating system is the linux kernel,
released in 1991 by Linus Trovalds, however much of its core user space
software comes from the gnu project. For this reason linux systems
may also be called gnu/linux.

#sources

- `git clone http://git.kernel.org/pub/scm/docs/man-pages/man-pages`

    the linux man pages, documenting the kernel and C interfaces to it.

    in special, look under

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

    Archilinux installation guide.

    Since Archlinux is very minimalistic, installing it can teach you a lot.

    Like LFS but you start at a higher level already.

- <http://www.cavecanen.org/linux/humour/horrorstories.txt>

    Real *NIX sysadmin horror stories of things gone terribly wrong.

#distributions

A linux distribution is a lsb complicant system.

Typically, distributions contain end user
applications such as text editors of music players, making it usable
out of the box for a large variety of non programmer users.

This work is left for third party enterprises of community projects such as Ubuntu
or Fedora which are maintained by Canonical and Red Had enterprises respectively.

lsb is meant to contain all the core tools that allow compliant applications
to be portable across any compliant distribution.

lsb does however specifies many more tools than POSIX
and supports almost all base tools used by user friendly applications
found in distributions

##find current distro

Get distro maintainer, name, version and version codename:

    lsb_release -a

lsb this standas for `linux standard base`

##install a new distro

Most distros are distributed in ISOs suitable to burning on a CD or DVD,
from which you can then boot the computer and install them.

It is also possible to put the CD or DVD image in a USB.

Such CDs or USBs are commonly called Live.

You can keep in mind that booting from a Live CD means that that CD
contains at least the Kernel image so that you load that image into RAM
instead of loading it from your HD.

If you are on a read only CD however,
you can usually not save any information to the CD while on a live boot,
so it makes no sense to save a file to the CD.

You could however mount your hard disk, and write to it after you booted from the CD.

You will need a free partition for the installation. Mo

###usb install

Some distros offer a Windows method of USB installation which does not destroy USB data completelly.

Some installers even allow you to reserve space on the USB for permanent storage,
so that you can use your OS from the USB just as if it were an small and fast HD.

If however you are already on Linux, you will probably have to destroy all USB information,
because the ISO image has to be the very first thing on your usb, therfore erasing essential
filesystem structures such as the main boot record partition table.

Of course, you can always recreate a filesystem in your USB and use it
as a storage device once you are done with the USB.

To install images on a USB you can do:

    dd bs=4M if=/path/to/iso.iso of=/dev/sdX

Where `/dev/sdX` is the mount point of the USB.

This will erase all data on the USB!

- `/dev/sdX` is the block device for the USB, and it can be found with:

        sudo lsblk -f

    The usb must not be mounted (`lsblk` shows no mountpoint).

    *Don't* write to the first partition `/dev/sdX1`, since what we want is to write
    to the start of the device, not to the start of its first partition!

###bootloader problems

Most distributions install their own bootloader, meaning that they rewrite the existing bootloader.

This means that if the new bootloader cannot recognize certain types of boot data on each partition,
you will not see those partitions as bootable.

This is for example the case if you install a distro with GRUB 2 (Ubuntu 13.04),
and then install another distro which uses GRUB (Fedora 17)

GRUB cannot recognize GRUB 2 booting data since it came before GRUB 2 existed,
so you will not see your old bootable partitions as bootable.

Therefore, if you have the choice, the best option in this case would be to fisrt install
the GRUB distro, and only then the GRUB 2 distro, so that in the end you will have GRUB 2,
which will see both partitions as bootable.

This can be corrected in 2 ways: from a live boot, or from an existing partition with GRUB 2.

####live boot

If you can Live boot in the distro that uses GRUB 2 things are easy.

Boot with the Live CD, and then simply reinstall the GRUB 2 bootloader,
using the GRUB 2 installer that comes with the Live CD,
so that on next system start GRUB 2 will be used,
and will recognize both GRUB and GRUB 2 partitions.

All that is needed to do this is to issue:

    sudo grub-install --root-directory=/media/grub2/system/mount/point /dev/sdX

Where:

- /media/grub2/system/mount/point

    Mountpoint for you grub2 system.

    You must have mounted it with `mount` before.

    Some distros like Ubuntu's Live CD already mount all possible systems,
    so you might not need to mount it.

    If that is the case, you can check where you partitio is mounted with `sudo mount -l`,
    and then looking into partitions that have the correct type and listing the files inside candidates
    to make sure that it is the correct partition.

- /dev/sdX

    Device file for the Hard disk you want to install GRUB on.

    Remember that GRUB bootloader is installed at the very start of the entire HD, and not of some partition,
    so it makes no sense to give a parition device such as `/dev/sda1` or `/dev/sda2`.

Source: <http://askubuntu.com/questions/59359/unable-to-boot-into-ubuntu-after-ubuntu-fedora-dual-boot/59376#59376>

####existing GRUB2 partitions

If you do not have access to a Live CD, you can mount the GRUB 2 partition,
and `chroot` into it, and then reinstall GRUB 2.

It will be just as if you were issuing that command from that partition.

Procedure: <http://askubuntu.com/questions/88384/how-can-i-repair-grub-how-to-get-ubuntu-back-after-installing-windows>

---

Keep in mind that what GRUB does is simply read its configuration files,
and after interpreting those write data to specifi points of the HD (Master boot record,
at the very beginning of the HD) instructions on how to boot.

#certification

the linux foundation offers certification and compliance verification
tools for distribution developpers and application developpers.

the list of certified distributions and products can be found here:
https://www.linuxbase.org/lsb-cert/productdir.php?by_lsb.

notable certified systems include:

- Ubuntu 9.4

    However not later versions up to time of writting

    [It seems that](http://askubuntu.com/questions/89125/does-ubuntu-follow-the-linux-standard-base-lsb)
    Ubuntu does not intend to fully comply
    on certain specific points, but only be highly compliant

- Red Hat Enterprise Linux 6.0

#linux and gnu

[linux and gnu][]

the user space programs of linux are mostly inherited from the *gnu project*
which was created in 1983 by Richard Stallman.

for example, the following central components originate from gnu:

- gcc
- glibc
- bash

it seems that the gnu project is not officially called like that anymore,
and has transformed into the *free software foundation* (fsf) also founded by Stallman
TODO check

amongst the projects of the fsf is the *gnu operating system*.
they are also active in legal causes and activism for free software

the gnu operating system is developping its own kernel called *HUD*,
but the own project states that it is not yet ready for broad usage

the fsf insists on caling what most people call linux as GNU/linux,
which sounds quite reasonable considering they developed a great part of
the userspace core

the gnu software foundation is the creator and current maintainer
of the GPL licence, and mostly uses that licence for its software and
is the main enforcer of its infringements

#lsb and posix

lsb is already highly posix compliant, and it states that it is on of its
long term goals meant to become fully posix compatible

incompatibility are being listed for future resolution

there some posix requirements that the linux kernel simply does not

#fhs

The filesystem hierarchy standard specifies base directories
for the system and what should go in them.

It is also maintained by the linux foundation, and followed by the lsb.

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
- libc: c standard libraries shared object
- libm: c math library shared object
- libncurses: for command line interfaces

##c++

- cstandard library shared objects are required

##interpreted languages

- python
- perl

##desktop

- opengl shared objects
- x11, gtk+, qt runtimes
- jpeg, png shared object libraries
- alsa (sound)

#basename conventions

not in the fhs, but you should know about

###^\.

hidden files

it is up to programs to decide how to treat them

###\.~$

backup file

###\.bak$

backup file

###\.orig$

original installation file

###\.d$

many theories, a plausible one:
differentiate `a.conf file` from `a.conf.d` dir
normally, all files in the `a.conf.d` dir will be sourced
as if they wre inside `a.conf`

#signals

Signals are an ANSI C concept, with extensions by POSIX and Linux.

Aspects which are defined to ANSI C or POSIX shall not be convered here.

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

Last time file or was accessed, for example via a `sys_read`
or `sys_execve` or `sys_readdir`.

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

Last time the file or directory data was modified, for example via a
`sys_write` call or file creation in the directory.

Those system calls do no modify the atime.

Those system calls also modify the ctime.

Metadata such as permissions and ownership are not considered.

Writting the same data twice updates mtime:

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

Only top level directory changes are considered,
since only those are stored in the directory data:

    mkdir d
    mkdir d/d
    stat d
    sleep 1
    touch d/d/a
    stat d
        #mtime unchanged

##ctime

Change time.

Last time inode information was changed, for example
permissions, owner, group.

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

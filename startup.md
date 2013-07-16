Info on how a linux system starts running.

Summary of the boot process: <http://www.ibm.com/developerworks/library/l-linuxboot/>

#BIOS

TODO

#bootloading

Bootloading is the name of the process for starting up the system.

The main job of this operation is loading the OS image (an executable) into memory and get it running.

The most popular bootloader for Linux now is Grub. LILO was a popular alternative in the past.
Windows has its own bootloader.

It is a program in BIOS that tries to find in all devices (hard disk, cd/dvd, flash drives, floppies, ...)
it can see for a Master Boot Record (MBR).

In normal desktop operation nowadays, the hard disk is the main MBR source,
but when you install your OS, you load it from either a cd / dvd or USB stick.

The MRB is the first 512 sector of the device found. It contains:

- a small piece of code (446 bytes) called the primary boot loader.

    This code will then be executed.

- the partition table (64 bytes) describing the primary and extended partitions

    TODO

It takes the fisrt MBR it finds.

The MBR can only be at the start of a physical partion, not of a logical partion.
This is why on bootloader configurations you give /dev/sda, instead of /dev/sda1-4 (TODO check)

The search order is deterministic and configurable.
The first initial black screen is shown by BIOS.
If you are quick enough on you keyboard, you can stop the default boot,
and enter BIOS options to choose for example which device to take MBR from.
This way you can tell your BIOS to take a live CD or USB even if the OS
is installed on the hard disk (usually default location to take MBR from).

#grub

TODO how does GRUB read the disk image and grub.cfg from the filesystem. We usually need an OS to read filesystems!

Grand Unified Bootloader.

If you have a Linux dual boot, and you see a menu prompting you to choose the OS,
there is a good chance that this is GRUB, since it is the most popular bootloader today.

It allows you basic graphical interaction even before starting any OS!

Everything is configurable, from the menu entries to the background image!
This is why Ubuntu GRUB is purple!

The main job for grub userspace utilities such as `grub-install` and `update-grub`
is to look at the input config files, interpret them and and write the output config information
to the correct locations on the hard disk so that they can be found at boot time.

The MBR is too small for all the features that GRUB developers wanted,
so they use it only to transfer control to another larger code section.

##versions

Grub has 2 versions

- 0.97, usually known just as GRUB, or Legacy GRUB.
- Grub >= 2, which is backwards incompatible, and has more features.

    grub 2 is still beta.

Some distros like Ubuntu have already adopted GRUB 2,
while others are still using GRUB for stability concerns.

Determine your GRUB version with:

    grub-install -v

Here we discuss GRUB 2.

##configuration

Input files:

-  `/etc/grub.d`
- `/etc/default/grub`

Generated files and data:

- `/boot/grub/grub.cfg`
- MBR bootstrap code

###/etc/default/grub

    sudo vim /etc/default/grub

- `GRUB_DEFAULT`: default OS choice if cursor is not moved.

	Starts from 0, the order is the same as shown at grub os choice menu.

- `GRUB_TIMEOUT` : time before auto OS choice in seconds

###/etc/grub.d/

Conatains executables.

Each one is called in alphabetical order, and its stdout is used by GRUB.

Create a menu entry:

    #!/bin/sh -e
    echo "stdout"
    echo "stderr" >&2
    cat << EOF
    menuentry "menuentry title" {
    set root=(hd0,1)
    -- boot parameters --
    }
    EOF

You will see `stdout` when running `update-grub`. stderr is ignored.

`set root=(hd0,1)` specifies the partition, here `sda1`. `hd0` means first device,
`1` means first partition. Yes, one if 0 based, and the other is 1 based.

`-- boot parameters --` depends on your OS.

Linux example:

    linux /boot/vmlinuz
    initrd /boot/initrd.img 

Windows example:

    chainloader (hdX,Y)+1 

It is common to add one OS menu entry per file so that it is easy to change their order (just change alphabetical order).

###os_prober

Looks for several OS and adds them automatically to GRUB menu.

Recognizes Linux and Windows.

TODO how to use it

###update-grub

Interpret input configuration files and update `/etc/default/grub` which will be used at boot time.

You must to this every time you change the input configuration files for the changes to take effect.

###grub-install

Interpret input configuration files and update the MBR on the given disk:

    sudo grub-install /dev/sda

If for example you install a new Linux distro, and you want to restore your old distro's GRUB configuration,
you must log into the old distro and do `grub-install`, therefore telling your system via the MBR to use
the installation parameters given on the old distro.

##sources

- <http://www.dedoimedo.com/computers/grub-2.html>

    great configuration tutorial

#boot directory

Usually located at `/boot/`.

It contains the following files:

- vmlinz-VERSION: the kernel compiled code, also knows as kernel image.

- config-VERSION: the kernel configuration options,
    generated at configuration before kernel compilation by `make menuconfig`

- abi-VERSION: TODO what is? looks like the kernel symbol table of exported symbols.

#init

First user-space process and parent of all processes!

It has pid 1.

It is the first child of the first kernel process, which has pid 0.

Last thing that is run at boot process.

Determines runlevel.

A great way to understand what happens after `init` is to use `pstree`.

This is distribution dependant.

#run levels

TODO understand better

Set runlevel to 6 which implies a reboot

Get current runlevel (POSIX 7):

    who -r

Therefore this is a POSIX 7 supported concept.

Set runlevel:

    #sudo init 6

Attention: this would cause the system to reboot.

#upstart

some systems such as Ubunutu use upstart, newer replacement to the `system v` init system

- `/etc/init`: upstart configuration files

	programs here are named services

- `/etc/init.d`: compatibility only system v rc dirs

	links to programs that get run on each runlevel at `/etc/rc\n.d/`

##service

Upstart interface to services.

Get status of all services:

    sudo service --status-all

Legend:

- `+`: started
- `-`: stopped
- `?`: unknow

    sudo service apache2 status
    sudo status apache2

    sudo service apache2 start
    sudo start apache2

    sudo service apache2 stop
    sudo stop apache2

    sudo service apache2 restart
    sudo restart apache2

TODO `service restart` vs `restart`?

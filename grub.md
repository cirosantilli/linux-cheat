# GRUB

Grand Unified Bootloader.

If you have a Linux dual boot, and you see a menu prompting you to choose the OS, there is a good chance that this is GRUB, since it is the most popular bootloader today.

It allows you basic graphical interaction even before starting any OS.

Everything is configurable, from the menu entries to the background image. This is why Ubuntu's GRUB is purple.

The main job for GRUB userspace utilities such as `grub-install` and `update-grub` is to look at the input configuration files, interpret them and write the output configuration information to the correct locations on the hard disk so that they can be found at boot time.

GRUB has knowledge about filesystems, and is able to read configuration files and the disk image from it.

## GRUB versions

GRUB has 2 versions

-   0.97, usually known just as GRUB, or Legacy GRUB.

-   GRUB >= 2, which is backwards incompatible, and has more features.

    GRUB 2 is still beta.

Some distros like Ubuntu have already adopted GRUB 2, while others are still using GRUB for stability concerns.

Determine your GRUB version with:

    grub-install -v

Here we discuss GRUB 2.

## configuration

Input files:

-  `/etc/grub.d`
- `/etc/default/grub`

Generated files and data after `sudo update-grub`:

- `/boot/grub/grub.cfg`
- MBR bootstrap code

### /etc/default/grub

    sudo vim /etc/default/grub

-   `GRUB_DEFAULT`: default OS choice if cursor is not moved.

    Starts from 0, the order is the same as shown at grub os choice menu.

-   `GRUB_TIMEOUT` : time before auto OS choice in seconds

-   `GRUB_CMDLINE_LINUX_DEFAULT`: space separated list of Kernel boot parameters.

    Sample:

        GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"

    The parameters will not be discussed here.

    Those parameters can also be edited from the boot menu for a single session by selecting the partition and clicking `e`.

	-   useless options on by default on Ubuntu 12.04 which you should really remove because they hide kernel state and potentially useful debug information:

        - `quiet`: suppress kernel messages.
        - `splash`: shows nice and useless image while the kernel is booting. On by default on Ubuntu 12.04. Remove this useless option,

### /etc/grub.d/

Contains executables.

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

### os_prober

Looks for several OS and adds them automatically to GRUB menu.

Recognizes Linux and Windows.

TODO how to use it

### update-grub

Interpret input configuration files and update `/etc/default/grub` which will be used at boot time.

You must to this every time you change the input configuration files for the changes to take effect.

### grub-install

Interpret input configuration files and update the MBR on the given disk:

    sudo grub-install /dev/sda

If for example you install a new Linux distro, and you want to restore your old distro's GRUB configuration, you must log into the old distro and do `grub-install`, therefore telling your system via the MBR to use the installation parameters given on the old distro.

## Bibliography

-   <http://www.dedoimedo.com/computers/grub-2.html>

    Great configuration tutorial.


# Install Operating System

How to install a new OS on your computer.

## Install a new distribution

Most distributions are distributed in ISOs suitable to burning on a CD or DVD, from which you can then boot the computer and install them.

It is also possible to put the CD or DVD image in a USB.

Such CDs or USBs are commonly called *Live*, and so is a session in which the OS was loaded from such media.

You can keep in mind that booting from a Live CD means that that CD contains at least the Kernel image so that you load that image into RAM instead of loading it from your HD.

If you are on a read only CD however, you can usually not save any information to the CD while on a live boot, so it makes no sense to save a file to the CD.

You could however mount your hard disk, and write to it after you booted from the CD.

You will need a free partition for the installation.

### USB install

The main parameters to watch for each method are:

- works for with distribution?
- can be done from which system?
- destroys existing data in USB?
- allows persistent storage?

#### From Windows

Pendrive Linux <http://www.pendrivelinux.com> is a very good tool that:

- works for multiple distributions
- can create persistent storage.

From Windows, there are methods of USB installation which does not destroy USB data completely.

Some installers even allow you to reserve space on the USB for persistent storage, so that you can use your OS from the USB just as if it were an small and fast HD.

#### dd method

If the `.iso` is a boot sector, which is the case for Ubuntu 14.04, you can use this method to install it from USB.

Destroys all data in USB.

No persistent storage.

Inner workings: put the ISO image as the very first thing on the USB, therefore erasing essential filesystem structures such as the main boot record partition table of the USB.

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

#### Persistent USB install

- <http://askubuntu.com/questions/16988/how-do-i-install-ubuntu-to-a-usb-key-without-using-startup-disk-creator>
- <https://wiki.archlinux.org/index.php/Installing_Arch_Linux_on_a_USB_key>

##### Virtual machine ISO INSTALL

<http://askubuntu.com/a/672839/52975>

##### usb-creator-gtk

Ubuntu specific.

Did not work for me: USB did not boot correctly.

Allows easy creation of persistent storage USB of up to 4GiB, and more with hacks.

    gksudo usb-creator-gtk

### ISO on Linux filesystem

GRUB can boot from ISO images stored inside a regular filesystem.

It appears as another regular entry on the GRUB menu.

So always keep an image around and GRUB setup in case you destroy your system.

This dispenses the use of an USB stick.

TODO get working:

- http://askubuntu.com/questions/340156/install-ubuntu-from-iso-image-directly-from-hard-disk-of-a-system-running-linux
- http://askubuntu.com/questions/24903/how-to-boot-from-an-iso-file-in-grub2
- http://askubuntu.com/questions/121212/using-a-bootable-live-cd-disk-image-mounted-on-the-hard-drive

### Bootloader problems

Most distributions install their own bootloader, meaning that they rewrite the existing bootloader.

This means that if the new bootloader cannot recognize certain types of boot data on each partition, you will not see those partitions as bootable.

This is for example the case if you install a distro with GRUB 2 (Ubuntu 13.04), and then install another distro which uses GRUB (Fedora 17)

GRUB cannot recognize GRUB 2 booting data since it came before GRUB 2 existed, so you will not see your old bootable partitions as bootable.

Therefore, if you have the choice, the best option in this case would be to first install the GRUB distro, and only then the GRUB 2 distro, so that in the end you will have GRUB 2, which will see both partitions as bootable.

This can be corrected in 2 ways: from a live boot, or from an existing partition with GRUB 2.

### Proprietary driver problems

Because of licensing issues, Ubuntu does not come with some proprietary drivers, which may lead to some functions being broken after installation.

To solve that, make sure that you try to install the proprietary drivers after installation.

Components which commonly fail include:

- graphics card
- WIFI card

#### Graphics card

##### Screen shows weird black and white pattern

If you graphics card is proprietary, Ubuntu boot may get locked on a black screen or a black screen with white patterns. In that case, follow the steps at: <http://askubuntu.com/a/162076/52975>, in particular:

- go the GRUB menu by holding shift at startup
- English
- `F6`
- nomodeset

Install, then add the proprietary drivers.

##### Cannot detect external display when you have proprietary AMD driver

<http://askubuntu.com/questions/71457/how-can-i-set-up-dual-monitor-display-with-ati-driver>

### Multiple hard disks

Watch out if you don't have multiple hard disks on your machine, in which case you will see `sda` and `sdb` on the installation process.

TODO: how to install on the second hard disk?

#### Live boot

If you can Live boot in the distro that uses GRUB 2 things are easy.

Boot with the Live CD, and then simply reinstall the GRUB 2 bootloader, using the GRUB 2 installer that comes with the Live CD, so that on next system start GRUB 2 will be used, and will recognize both GRUB and GRUB 2 partitions.

All that is needed to do this is to issue:

    sudo grub-install --root-directory=/media/grub2/system/mount/point /dev/sdX

Where:

-   `/media/grub2/system/mount/point`

    Mount point for you GRUB 2 system.

    You must have mounted it with `mount` before.

    Some distros like Ubuntu's Live CD already mount all possible systems, so you might not need to mount it.

    If that is the case, you can check where you partition is mounted with `sudo mount -l`, and then looking into partitions that have the correct type and listing the files inside candidates to make sure that it is the correct partition.

-   `/dev/sdX`

    Device file for the Hard disk you want to install GRUB on.

    Remember that GRUB bootloader is installed at the very start of the entire HD, and not of some partition, so it makes no sense to give a partition device such as `/dev/sda1` or `/dev/sda2`.

Source: <http://askubuntu.com/questions/59359/unable-to-boot-into-ubuntu-after-ubuntu-fedora-dual-boot/59376#59376>

#### Existing GRUB 2 partitions

If you do not have access to a Live CD, you can mount the GRUB 2 partition,
and `chroot` into it, and then reinstall GRUB 2.

It will be just as if you were issuing that command from that partition.

Procedure: <http://askubuntu.com/questions/88384/how-can-i-repair-grub-how-to-get-ubuntu-back-after-installing-windows>

---

GRUB simply read its configuration files, and after interpreting those write data to specific points of the HD (Master boot record, at the very beginning of the HD) instructions on how to boot.

## 32 vs 64 bit

64 bit is faster and already stable: use it.

Every new consumer CPU is 64 bit.

64 bit CPUs are backwards compatible with 32 bit, this is why a 32 bit kernel can be run inside any 64 bit CPU.

In the past, there were some issues as the transition was still happening. Not things are stable enough.

Canonical used to say: prefer 32 bit Ubuntu, but not anymore.

Open source software plays nicely with the transition, as you or the package manager just compiles everything to whichever supported arch. 

In windows, which has less open source software, lots of software is still 32 bit and you only get the 32 bit binary.

Run 32 bit binary in 64 bit Kernel: <http://askubuntu.com/questions/359156/how-do-you-run-a-32-bit-program-on-a-64-bit-version-of-ubuntu>

Docker only supports 64 bit: <https://github.com/dotcloud/docker>

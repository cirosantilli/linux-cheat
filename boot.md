# Boot

Info on the boot process and its configuration.

## BIOS

TODO

## Bootload

Bootloading is the name of the process for starting up the system, in particular loading the kernel code, also called kernel image, into RAM memory.

Summary of the boot process:

- <http://www.ibm.com/developerworks/library/l-linuxboot/>
- <http://www.thegeekstuff.com/2011/02/linux-boot-process/>

The first thing the computer does is to run fixed code from the BIOS.

It tries to find all the devices all devices that can contain a kernel image like: hard disk, CD/DVD, flash drives, floppies.

It searches for the Master Boot Record (MBR).

In normal desktop operation, the hard disk is the main MBR source, but when you install your OS, you load it from either a CD / DVD or USB stick.

The search order is deterministic and configurable. Typically the first and default option is the hard disk.

The first splash screen shown to the users comes from this process.

If you are quick enough on you keyboard, you can stop the default boot, and manually chose another boot source.

This way you can tell your BIOS to take a live CD or USB even if the OS is installed on the hard disk.

## Second stage bootloader

The 512B of the MBR is a too little space for having a flexible boot system.

The MBR points to a second stage bootloader in its disk which which will do the actual booting.

The most popular second stage bootloader for Linux now is GRUB. LILO was a popular alternative in the past. Windows has its own bootloader.

## boot directory

Usually located at `/boot/`.

It contains the following files:

- `config-VERSION`: the kernel configuration options, generated at configuration before kernel compilation by `make menuconfig`
- `abi-VERSION`: TODO what is? Looks like the kernel symbol table of exported symbols.

### vmlinuz

Compiled kernel compressed with gzip, thus the `Z`

#### vmlinux

#### bzimage

<http://unix.stackexchange.com/questions/5518/what-is-the-difference-between-the-following-kernel-makefile-terms-vmlinux-vml>

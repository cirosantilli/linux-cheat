# Filesystem

Filesystems and related concepts: hard disks, mounting, partitions, block devices.

## Implementation location

The most common filesystems are implemented directly in the kernel under `fs/`, e.g. `fs/ext2` and `fs/ntfs`.

You can also implement filesystems with:

- a kernel module
- FUSE

See:

- <http://stackoverflow.com/questions/4714056/how-to-implement-a-very-simple-filesystem>
- <http://stackoverflow.com/questions/2189778/implementing-basic-file-system>

## Filesystem format

Determines how data will be efficiently stored in the hard disk in a linear manner.

Very complex design, which must consider:

- how to store tree structures like directories?
- how to find things efficiently?
- if power goes down, will the user lose all data?

ext2, ext3 and ext4 are the ones mainly used in Linux today.

On ext4, only one dir is created at the root: lost+found

Other important filesystems:

- NTFS: windows today
- FAT:  DOS
- MFS:  Macintosh File System. Mac OS X today.

To find out types see blkid or lsblk

Each partition can have a different filesystem.

When creating partitions for external storage devices such as USB stick nowadays, the best option is NTFS since Linux can read write to it out of the box, and it can be used on the 95% of computers because they use Windows (which does not read / write to ext out of the box.)

### Partition table

Contained in the MBR.

The partition table is optional: <http://askubuntu.com/questions/276582/is-it-safe-to-use-a-usb-external-drive-without-a-valid-partition-table>

If not present, most systems will search for a partition starting at the very beginning of the disk.

In such case, the partition will be mounted directly at `/dev/sdb`, not `/dev/sdb1`

## Format disks

To format a disk is to prepare it for initial utilization, often destroying all data it contains.

Disk formating consists mainly of two steps:

- create a partition table. This can be done with a tool such as `fdisk`.
- create a filesystem. This can be done with a tool from the `mkfs.XXX` family.

GUI tools such as gparted exist to make both those steps conveniently.

## Hard disks

Hard disks are represented by the system as block devices.

However, they have physical peculiarities which make their performance characteristics different from block devices such as USB sticks.

The following parameters are relevant only to hard disks:

- sectors: smallest addressable memory in HD. You must get the whole sector at once.
- tracks
- cylinders
- heads

To understand those concepts, you must visualize the hard disk's physical arrangement:

- <http://osr507doc.sco.com/en/HANDBOOK/hdi_dkinit.html>
- <http://en.wikipedia.org/wiki/Track_%28disk_drive%29>

Those parameters can be gotten with commands such as `sudo fdisk -l`.

## Create filesystems

Find all commands to make filesystems:

    ls -l /sbin | grep mk

Sample output:

    -rwxr-xr-x 1 root root   26712 Feb 18 18:17 mkdosfs
    -rwxr-xr-x 1 root root   88184 Jan 2 2013 mke2fs
    -rwxr-xr-x 1 root root   9668 Feb 4 21:49 mkfs
    -rwxr-xr-x 1 root root   17916 Feb 4 21:49 mkfs.bfs
    -rwxr-xr-x 1 root root   30300 Feb 4 21:49 mkfs.cramfs
    lrwxrwxrwx 1 root root     6 Jan 2 2013 mkfs.ext2 -> mke2fs
    lrwxrwxrwx 1 root root     6 Jan 2 2013 mkfs.ext3 -> mke2fs
    lrwxrwxrwx 1 root root     6 Jan 2 2013 mkfs.ext4 -> mke2fs
    lrwxrwxrwx 1 root root     6 Jan 2 2013 mkfs.ext4dev -> mke2fs
    -rwxr-xr-x 1 root root   26220 Feb 4 21:49 mkfs.minix
    lrwxrwxrwx 1 root root     7 Feb 18 18:17 mkfs.msdos -> mkdosfs
    lrwxrwxrwx 1 root root    16 Feb 25 14:54 mkfs.ntfs -> /usr/sbin/mkntfs
    lrwxrwxrwx 1 root root     7 Feb 18 18:17 mkfs.vfat -> mkdosfs
    -rwxr-xr-x 1 root root   18000 Mar 12 04:43 mkhomedir_helper
    -rwxr-xr-x 1 root root   87484 Feb 25 14:54 mkntfs
    -rwxr-xr-x 1 root root   22152 Feb 4 21:49 mkswap

Where:

- `mkfs.XXX` are uniformly named front-ends for filesystem creation
- `mkfs` is a frontend for all filesystem types.

You should only use on partition devices (ex: `sda1`), not on the entire devices (ex: `sda`).

If you want to edit the partition table, first use a tool like `fdisk`.

## /dev/sdX

## /dev/hdX

## sda

## sdb

## hda

Each hard disk and partition corresponds to device file.

There are many types of device files. In particular, hard disks and partitions are block device files.

Good tools to visualize block device files include `lsblk` and `gparted`.

Like all device files, block device files are kept under `/dev`.

    ls -l /dev | grep -E ' (sd|hd)..?$'

Sample output:

    hda
    hda1
    hda2
    hda5
    sdb
    sdb1
    sdb2
    sdb3
    hdc

The standard naming scheme is:

- `sd` and `hd` are the type of disk
- `sda` is the first hard disk, `sdb` is the second, `sdc` the third, etc.
- `sda1` is the primary partition of `sda`, `sda2` the second, etc.
- `sda5` is the first *logical* partition of `sda`. It starts at 5 because there can only be 4 primary partitions.

If a MBR is not present and a filesystem starts directly at the start of the device, then `sda` will be the partition itself.

### SATA

### IDE

### PATA

### Parallel ATA

### hd vs sd

`hd` is for IDE disks, `sd` for SATA disks.

Type, major number: block, `8`.

These are two standards of interface between hard disk and motherboard, with different connectors.

SATA stands for Serial Advanced Technology Attachment (or Serial ATA) and IDE is also called Parallel ATA or PATA.

But by the beginning of 2007, SATA had largely replaced IDE in all new systems.

Both have the same device number 8.

<http://www.diffen.com/difference/IDE_vs_SATA>

### SCSI

Both SATA and IDE are SCSI. This is why both `hd` and `sd` have the same major device number 8.

<https://en.wikipedia.org/wiki/SCSI>

## Raw device

<http://en.wikipedia.org/wiki/Raw_device>

Bypasses the OSs filesystem management like caching, allowing user programs to do it

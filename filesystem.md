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

## Partitions

There are 2 main types of partitions: MBR or GPT.

### MBR

You can only have 4 primary partitions.

Each one can be either divided into logical any number of logical partitions partitions.

A primary partition that is split into logical partitions is called an extended partition.

Primary partitions get numbers from 1 to 4.

Logical partitions get numbers starting from 5.

You can visualize which partition is inside which disk with `sudo lsblk -l`.

TODO more common?

### GPT

Arbitrary amount of primary partitions.

No logical partitions.

You should unmount partitions before making change to them.

To get info on partitions, start/end, filesystem type and flags, consider: `parted`, `df -f`

### Home partition

If you are a developer, create a separate partition and put your home on the root `/` of that partition.

Benefits:

- you can easily share your home between multiple operating systems: just mount it up, and all your user configs will be automatically reused across multiple development environments.
- if your home HD gets filled with large downloads, your system won't get into trouble,
since it uses a separate partition.

Use the same username on new systems, and mount the partition automatically with `fstab`. For every new system, just copy the fstab line.

30GiB is a good size for each root partition. Leave everything else for the home partition.

### Partition table

Contained in the MBR.

The partition table is optional: <http://askubuntu.com/questions/276582/is-it-safe-to-use-a-usb-external-drive-without-a-valid-partition-table>

If not present, most systems will search for a partition starting at the very beginning of the disk.

In such case, the partition will be mounted directly at `/dev/sdb`, not `/dev/sdb1`

## MBR

The MBR is the first 512 sector of the device found. It contains:

-   a small piece of code (446 bytes) called the primary boot loader.

    This code will then be executed.

    Most often, all it does it to load a second stage bootloader like GRUB.

-   the partition table (64 bytes) describing the primary and extended partitions.

-   2 bytes for MBR validation check.

    It is a fixed magic number <http://stackoverflow.com/questions/1125025/what-is-the-role-of-magic-number-in-boot-loading-in-linux>, that can be used to:

    - check if the device has a MBR
    - check endianess

The MBR can only be at the start of a physical partition, not of a logical partition.

This is why on bootloader configurations you give `/dev/sda`, instead of `/dev/sda1-4`.

## fuseblk

TODO. NTFS partitions as such.

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

## tune2fs

Get and set parameters of ext filesystems that can be tuned after creation.

List all parameters:

    sudo tune2fs -l /dev/sda5

## gparted

GUI to `fdisk` + `mke2fs.`

Very powerful and simple to use.

## parted

Get information on all partitions

Very useful output form:

    sudo parted -l

Sample output:

    Number Start  End   Size  Type   File system   Flags
    1   1049kB 1574MB 1573MB primary  ntfs      boot
    2   1574MB 102GB  100GB  primary  ntfs
    4   102GB  485GB  384GB  extended
    5   102GB  465GB  363GB  logical  ext4
    7   465GB  481GB  16.7GB logical  ext4
    6   481GB  485GB  4005MB logical  linux-swap(v1)
    3   485GB  500GB  14.7GB primary  ntfs

## sda

## sdb

## hda

## Device files

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

### hd vs sd

`hd` is for IDE disks, `sd` for SATA disks.

These are two standards of interface between hard disk and motherboard, with different connectors.

SATA stands for Serial Advanced Technology Attachment (or Serial ATA) and IDE is also called Parallel ATA or PATA.

But by the beginning of 2007, SATA had largely replaced IDE in all new systems.

<http://www.diffen.com/difference/IDE_vs_SATA>

## Raw device

<http://en.wikipedia.org/wiki/Raw_device>

Bypasses the OSs filesystem management like caching, allowing user programs to do it

## sr0

CD DVD.

`/dev/cdrom` is a symlink to it.

## mmcblk0

A SanDisk SD card had a device named `mmcblk0`.

## /dev/disk

Symlinks to partition identifiers.

Allows you to get identifier info.

If id no present, link not there.

Example:

    cd /dev/disk/
    ls -l
    by-id
    by-label
    by-path
    by-uuid

    ls -l by-id

## fsck

File System Check.

Check and repair Linux filesystems.

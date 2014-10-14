Filesystems and related concepts: hard disks, mounting, partitions, block devices.

#du

POSIX 7

Mnemonic: Disk Usage.

Get disk usage per file/dir:

    du -hs * | sort -hr

- `-h`: human readable: GiB, MiB, B
- `-s`: summarize: only for dirs in *, not subdirs

#df

POSIX 7

Mnemonic: Disk Fill.

List mounted filesystems:

    df -Th

- `-h`: human readable sizes in powers of 1024.
- `-T`: also show partition type (GNU extension)

Sample output:

    Filesystem     Type         Size  Used Avail Use% Mounted on
    /dev/sda7      ext4          29G   15G   13G  55% /
    udev           devtmpfs     1.9G   12K  1.9G   1% /dev
    tmpfs          tmpfs        376M  988K  375M   1% /run
    none           tmpfs        5.0M     0  5.0M   0% /run/lock
    none           tmpfs        1.9G  428K  1.9G   1% /run/shm
    /dev/sda5      ext4         320G  168G  136G  56% /home/ciro
    bindfs         fuse.bindfs   29G   15G   13G  55% /home/ciro/gitlab
    /dev/sdb1      fuseblk      932G  704G  228G  76% /media/DC74FA7274FA4EB0

Sort by total size:

    df -h | sort -hrk2

Sample output:

    Filesystem  Size  Used Avail Use% Mounted on
    /dev/sdb1   932G  704G  228G  76% /media/DC74FA7274FA4EB0
    /dev/sda5   320G  168G  136G  56% /home/ciro
    /dev/sda7    29G   15G   13G  55% /
    bindfs       29G   15G   13G  55% /home/ciro/gitlab
    none        1.9G  428K  1.9G   1% /run/shm
    udev        1.9G   12K  1.9G   1% /dev
    tmpfs       376M  988K  375M   1% /run
    none        5.0M     0  5.0M   0% /run/lock

Also show partition filesystems type:

    df -T

##i

Get percentage of free / used inodes:

    df -i

Sample output:

    Filesystem    Inodes IUsed  IFree IUse% Mounted on
    /dev/sda5   22167552 832797 21334755  4% /
    /dev/sda2   30541336 189746 30351590  1% /media/win7

This is interesting because the number of inodes is a limitation of filesystems in addition to the amount of data stored.

This limits the amount of files you can have on a system in case you have lots of small files.

#Partitions

There are 2 main types of partitions: MBR or GPT.

##MBR

You can only have 4 primary partitions.

Each one can be either divided into logical any number of logical partitions partitions.

A primary partition that is split into logical partitions is called an extended partition.

Primary partitions get numbers from 1 to 4.

Logical partitions get numbers starting from 5.

You can visualize which partition is inside which disk with `sudo lsblk -l`.

TODO more common?

##GPT

Arbitrary amount of primary partitions.

No logical partitions.

You should unmount partitions before making change to them.

To get info on partitions, start/end, filesystem type and flags, consider: `parted`, `df -f`

##Home partition

If you are a developer, create a separate partition and put your home on the root `/` of that partition.

Benefits:

- you can easily share your home between multiple operating systems: just mount it up, and all your user configs will be automatically reused across multiple development environments.
- if your home HD gets filled with large downloads, your system won't get into trouble,
since it uses a separate partition.

Use the same username on new systems, and mount the partition automatically with `fstab`. For every new system, just copy the fstab line.

30GiB is a good size for each root partition. Leave everything else for the home partition.

##Partition table

Contained in the MBR.

The partition table is optional: <http://askubuntu.com/questions/276582/is-it-safe-to-use-a-usb-external-drive-without-a-valid-partition-table>

If not present, most systems will search for a partition starting at the very beginning of the disk.

In such case, the partition will be mounted directly at `/dev/sdb`, not `/dev/sdb1`

#MBR

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

#fuseblk

TODO. NTFS partitions as such.

#Format disks

To format a disk is to prepare it for initial utilization, often destroying all data it contains.

Disk formating consists mainly of two steps:

- create a partition table. This can be done with a tool such as `fdisk`.
- create a filesystem. This can be done with a tool from the `mkfs.XXX` family.

GUI tools such as gparted exist to make both those steps conveniently.

#fdisk

View and edit partition tables and disk parameters.

REPL interface.

Does not create filesystems. For that see: `mke2fs` for ext systems.

Mnemonic: Format disk.

Better use gparted for simple operations if you have X11

To view/edit partitions with interactive CLI prompt interface.

##l

Show lots of partition and disk data on all disks:

    sudo fdisk -l

Sample output for each disk:

    Disk /dev/sda: 500.1 GB, 500107862016 bytes
    255 heads, 63 sectors/track, 60801 cylinders, total 976773168 sectors
    Units = sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 4096 bytes
    I/O size (minimum/optimal): 4096 bytes / 4096 bytes
    Disk identifier: 0x7ddcbf7d

    Device Boot   Start     End   Blocks  Id System
    /dev/sda1  *    2048   3074047   1536000  7 HPFS/NTFS/exFAT
    /dev/sda2     3074048  198504152  97715052+  7 HPFS/NTFS/exFAT
    /dev/sda3    948099072  976771071  14336000  7 HPFS/NTFS/exFAT
    /dev/sda4    198504446  948099071  374797313  5 Extended
    Partition 4 does not start on physical sector boundary.
    /dev/sda5    198504448  907638783  354567168  83 Linux
    /dev/sda6    940277760  948099071   3910656  82 Linux swap / Solaris
    /dev/sda7    907640832  940267519  16313344  83 Linux

##REPL

Edit partitions for `sdb` on REPL interface:

    sudo fdisk /dev/sdb

Operation: make a list of changes to be made, then write them all to disk and exit with `w` (write).

Most useful commands:

- `-m`: list options
- `-p`: print info on partition, same as using `-l` option.
- `-o`: create new DOS partition table.
- `-n`: create new partition.
- `-d`: delete a partition.
- `-w`: write enqueued changes and exit.

#Hard disks

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

#Filesystem

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

##tmpfs

##ramfs

Types of filesystems that exists only in RAM. It is therefore fast and can only be small.

Can be useful if you want to speed up some filesystem operations and have enough RAM for it.

tmpfs vs ramfs:

-   tmpfs has a fixed size: it does not grow dynamically and raises an error if you blow the limit.

    ramfs can grow dynamically and does not use swap.

-   tmpfs uses swap, ramfs does not.

Create a tmpfs:

    mkdir -p /mnt/tmp
    mount -t tmpfs -o size=20m tmpfs /mnt/tmp

Create a ramfs:

    mkdir -p /mnt/ram
    mount -t ramfs -o size=20m ramfs /mnt/ram

#Create filesystems

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

#mke2fs

Make ext[234] partitions.

Consider using gparted if you have X11.

- `-t`: type: ext2, ext3, ext4
- `-L`: label
- `-i`: inodes per group (power of 2)
- `-j`: use ext3 journaling. TODO for `-t` ext3/4, is it created by default?

#tune2fs

Get and set parameters of ext filesystems that can be tuned after creation.

List all parameters:

    sudo tune2fs -l /dev/sda5

#mkswap

#Swap partition

The swap partition is used by OS to store RAM that is not being used at the moment to make room for more RAM.

Should be as large as your RAM more or less, or twice it.

Can be shared by multiple OS, since only one OS can run at a time.

Make swap partition on a file in local filesystem:

    sudo dd if=/dev/zero of=/swapfile bs=1024 count=1024k
    sudo mkswap /swapfile
    sudo swapon /swapfile

For that to work every time:

    sudo bash -c 'echo "/swapfile    none  swap  sw   0    0" >> /etc/fstab'

Turn swap on on partition `/dev/sda7`:

    sudo swapon /dev/sda7

Find the currently used swap partition:

    swapon -s

Disable swapping:

    sudo swapoff

Make a swap partition on partition with random UUID.

    sudo mkswap -U random /dev/sda7

Swap must be off.

#gparted

GUI to `fdisk` + `mke2fs.`

Very powerful and simple to use.

#parted

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

#sda

#sdb

#hda

#Device files

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
- `sda`         is the first hard disk, `sdb` is the second, `sdc` the third, etc.
- `sda1`        is the primary partition of `sda`, `sda2` the second, etc.
- `sda5`        is the first *logical* partition of `sda`. It starts at 5 because there can only be 4 primary partitions.

If a MBR is not present and a filesystem starts directly at the start of the device, then `sda` will be the partition itself.

##SATA

##IDE

##hd vs sd

`hd` is for IDE disks, `sd` for SATA disks.

These are two standards of interface between hard disk and motherboard, with different connectors.

SATA stands for Serial Advanced Technology Attachment (or Serial ATA) and IDE is also called Parallel ATA or PATA.

But by the beginning of 2007, SATA had largely replaced IDE in all new systems.

<http://www.diffen.com/difference/IDE_vs_SATA>

#sr0

CD DVD.

`/dev/cdrom` is a symlink to it.

#mmcblk0

A SanDisk SD card had a device named `mmcblk0`.

##lsblk

List block devices, including those which are not mounted.

    sudo lsblk

Sample output:

    NAME    MAJ:MIN RM  SIZE   RO TYPE MOUNTPOINT
    sda     8:0     0   465.8G 0  disk
    |-sda1  8:1     0    1.5G  0  part
    |-sda2  8:2     0   93.2G  0  part /media/win7
    |-sda3  8:3     0   13.7G  0  part
    |-sda4  8:4     0     1K   0  part
    |-sda5  8:5     0   338.1G 0  part /
    |-sda6  8:6     0    3.7G  0  part [SWAP]
    `-sda7  8:7     0   15.6G  0  part
    sdb     8:16    0   931.5G 0  disk
    `-sdb1  8:17    0   931.5G 0  part /media/ciro/DC74FA7274FA4EB0

`-f`: show mostly information on filesystems:

    sudo lsblk -f

Sample output:

    NAME  FSTYPE LABEL      MOUNTPOINT
    sda
    |-sda1 ntfs  SYSTEM_DRV
    |-sda2 ntfs  Windows7_OS   /media/win7
    |-sda3 ntfs  Lenovo_Recovery
    |-sda4
    |-sda5 ext4          /
    |-sda6 swap          [SWAP]
    `-sda7 ext4
    sdb
    `-sdb1 ntfs          /media/ciro/DC74FA7274FA4EB0

`-o`: select which columns you want exactly. Most useful information for humans:

    sudo lsblk -o NAME,FSTYPE,MOUNTPOINT,LABEL,UUID,SIZE

`-n`: don't output header with column names. Good way to get information computationally. E.g., get UUID of `/dev/sda1`:

    sudo lsblk -no UUID /dev/sda1

#UUID

Unique identifier for a partition. Field exists in ext and NTFS.

Given when you create of format a partition.

Can be found with tools such as `lsblk -o`, `blkid`, or `gparted`.

Get UUID of a device:

    sudo lsblk -no UUID /dev/sda1

Get all devices:

    sudo lsblk -no UUID /dev/sda1

#blkid

Get UUID, label and filesystem type for all partitions

    sudo blkid

#Label

An ext partitions concept.

Determines the mount name for the partition.

Should be unique, but not sure this is enforced. TODO

##e2label

Get / set ext[234] label info

Set new label for partition:

    sudo e2label /dev/sda7
    sudo e2label /dev/sda new_label

Each partition may have a label up to 16 chars length. If it does, the partition will get that name when mounted.

List all labels:

    sudo blkid

#/dev/disk

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

#Mount

Mounting is the operation of making a block device available for operations such as open, read and write.

This is what you must do before you can use devices such as USB.

Many modern distributions mount such devices automatically.

Linux has system calls dedicated to this operation.

The block device will be mounted on a directory in the filesystem, and from then on shall be essentially indistinguishable from normal directories. This directory is known as mount point.

If the directory was not empty, old contents will be hidden.

You can mount several times on the same point, the last operation hiding the old mounted system until the latest mounted system is unmounted.

You can mount with the mount utility, and unmount with the umount utility.

##mount utility

Mount block device file on filesystem:

    sudo mount /dev/sda1 /media/win/

List all mount points:

    sudo mount -l

Sample output:

    /dev/sda5 on / type ext4 (rw,errors=remount-ro)

Shows:

- device if any
- mountpoint
- type
- flags

##bind

Make one dir a copy of the other, much like a hardlink does to files.

Requires `sudo` like mount because it uses kernel internals to do it. For an userspace solution consider `bindfs`.

    mkdir a
    mkdir b
    sudo mount --bind a b
    touch a/a
    touch b/b
    [ `ls a` = $'a\nb' ] || exit 1
    [ `ls b` = $'a\nb' ] || exit 1
    sudo umount b
    [ `ls a` = $'a\nb' ] || exit 1
    [ -z `ls b` ] || exit 1

##bindfs

Like bind, but allows you to mess with ownership and permissions.

Useful command:

    sudo bindfs -u a -g a --create-for-user=b --create-for-group=b from to

Mounts `from/` on `to/`.

`b` must exist.

`-u a -g a`: everything seen on `to` is owned by `a:a`

Everything created / saved on b, is created on `a` with owner `b:b`.

Unmount:

    fusermount -u /home/johnc/ISO-images

##Unmount

##umount

Unmount what is mounted on given directory:

    sudo umount /media/win/

Unmount block device from all directories it is mounted:

    sudo umount /dev/sdb1

`umount` can only be used if the device is not in use. To determine which processes are using a device, use `lsof` or `fuser`.

##fstab

This is about the config file located at `/etc/fstab`.

Mount partitions at startup.

Good sources:

    man fstab
    man mount

- <http://www.tuxfiles.org/linuxhelp/fstab.html>
- <https://wiki.archlinux.org/index.php/Fstab>

List partitions that should mount up at startup and where to mount them:

    sudo cp /etc/fstab /etc/fstab.bak
    sudo vim /etc/fstab
    sudo mount -a

Apply changes only mounts `auto` option set.

Syntax:

    <file system> <mount point>  <type> <options>    <dump> <pass>
    1             2              3      4            5      6

1.  identifier to the file system.

    E.g.:

    - `/dev/sda1`
    - `UUID=ABCD1234ABCD1234`
    - `LABEL=mylabel`

2.  where it will get mounted.

    The most standard option is to make a subdir of `/media` like `/media/windows`.

    This dir must exist before mount and preferably be used only for mounting a single filesystem.

    It seems that fstab can auto create/remove the missing dirs.

3.  Type. ext[234], NTFS, etc.

4.  Options.

    - `defaults`. Use default options for the current filesystem type.

5.  Dump. Used by the dump utility to make backups. If `0`, don't make backups. If `1`, make them.

6.  Pass. Used by `fsck`. If `0` the FS is ignored by `fsck`, `1` it is checked with highest priority, `2` checked with smaller priority.

Use 1 for the primary partition, `2` for the others.

##mtab

Explained in:

    man mount

`/etc/mtab` contains information about currently mounted filesystems.

Mount without arguments cats it:

    mount

This file is only intended to be read, as it is modified by `mount` automatically.

Its format is compatible with `fstab`, although copying lines directly is not very useful as it refers to block devices by device file, which can change arbitrarily.

Sample lines of the file:

    /dev/sda7 / ext4 rw,errors=remount-ro 0 0
    proc /proc proc rw,noexec,nosuid,nodev 0 0
    sysfs /sys sysfs rw,noexec,nosuid,nodev 0 0
    none /sys/fs/fuse/connections fusectl rw 0 0
    /dev/sdb1 /media/SYSTEM_DRV fuseblk rw,nosuid,nodev,allow_other,default_permissions,blksize=4096 0 0

##Auto mount Windows filesystems

To mount Windows filesystems such as NTFS or DOS use:

    umask=111,dmask=000

This way, dirs will be 000 and files 666 (not executable).

##DVD

Mounting DVDs / USBs is similar to mounting partitions:

    /dev/cdrom 	/media/dvd 	noauto 	ro 0 0

However if you use auto, you always get errors when the DVD is empty.

It is best to use auto, because DVD can be of several formats.

##mountall

mountall is on Ubuntu 12.04 the utility that reads fstab and mounts all the filesystems listed there.

##/proc/mounts

List mounted filesystems:

    cat /proc/mounts

#fsck

File System Check.

Check and repair Linux filesystems.

#inotify

Take action whenever file changes: <http://superuser.com/questions/181517/how-to-execute-a-command-whenever-a-file-changes>

Portability: Linux only. Relies directly on the `inotify` system calls. More info at:

    man inotify

Ubuntu install:

    sudo aptitude install -y inotify-tools

Usage single file:

    cd /tmp
    f=file
    echo a > "$f"
    while inotifywait -e close_write "$f"; do cat "$f"; done

`make` on any directory changes with nice separator between commands:

	while inotifywait -qq -e 'close_write,moved_to,create' '.'; do printf '\n%70s\n' | tr ' ' '='; make --no-print-directory; done

`-q` quiet to stop it from printing one message every time it starts watching, `-qq` to print nothing at all.

Go to another shell and:

    cd /tmp
    echo b > file

Sample output on the first shell:

    Setting up watches.
    Watches established.
    file CLOSE_WRITE,CLOSE
    b

If the file is replaced by a different file rather than written to which is what most editors do, it process dies.

Workaround: monitor directory:

    cd /tmp
    f=file
    while true; do
      change=$(inotifywait -e close_write,moved_to,create .)
      change=${change#./ * }
      if [ "$change" = "$f" ]; then make; fi
    done

And then it works

    vim /tmp/file

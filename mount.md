# mount

Mounting is the operation of making a block device visible as a directory with files in a filesystem.

This is what you must do before you can use devices such as USB.

Linux has the `mount` and `umount` system calls.

There are also `mount` and `umount` `util-linux` command line front-ends.

## Mount multiple times

If the directory was not empty, old contents will be hidden.

You can mount several times on the same point, the last operation hiding the old mounted system until the latest mounted system is unmounted.

## Basic usage

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

## t

Filesystem type to mount.

### /proc/filesystems

List of filesystems that the kernel knows how to mount.

One of those must be passed as a parameter to the `mount` system call.

## o

## Options

Control how the mount will be made.

Some of those are passed as `mountflags` flags, others as `void* data` to the system call.

## bind

Set the `MS_BIND` `mountflags` flag of the system call.

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

## Unmount

## umount

Unmount what is mounted on given directory:

    sudo umount /media/win/

Unmount block device from all directories it is mounted:

    sudo umount /dev/sdb1

`umount` can only be used if the device is not in use. To determine which processes are using a device, use `lsof` or `fuser`.

## fstab

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

## mtab

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

## Auto mount Windows filesystems

To mount Windows filesystems such as NTFS or DOS use:

    umask=111,dmask=000

This way, directories will be 000 and files 666 (not executable).

## DVD

Mounting DVDs / USBs is similar to mounting partitions:

    /dev/cdrom 	/media/dvd 	noauto 	ro 0 0

However if you use auto, you always get errors when the DVD is empty.

It is best to use auto, because DVD can be of several formats.

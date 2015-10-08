# mount

Mounting is the operation of making a block device visible as a directory with files in a filesystem.

This is what you must do before you can use devices such as USB.

Linux has the `mount` and `umount` system calls.

There are also `mount` and `umount` `util-linux` command line front-ends.

Not POSIX.

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

## o

## Options

Control how the mount will be made.

Some of those are passed as `mountflags` flags, others as `void* data` to the system call.

### loop

Example: create a file that contains a filesystem:

    dd if=/dev/zero of=a.ex2 bs=1024 count=64
    echo y | mke2fs -t ext2 a.ex2
    mkdir -p d
    # Since no specific loop device file is given (loop0, loop1, etc.),
    # find the first free one.
    sudo mount a.ex2 d -o loop
    # Do stuff
    sudo umount d

Type autodetect usually works in this case, so you can type just:

    sudo mount a.ex2 d

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

## Mount entire disk image with multiple partitions in it

- <http://unix.stackexchange.com/questions/9099/reading-a-filesystem-from-a-whole-disk-image>
- <http://superuser.com/questions/117136/how-can-i-mount-a-partition-from-dd-created-image-of-a-block-device-e-g-hdd-u>
- <http://askubuntu.com/questions/69363/mount-single-partition-from-image-of-entire-disk-device>

## mtab

Explained in:

    man mount

`/etc/mtab` contains a list of filesystems maintained by the `mount` and `umount` programs.

This file is only intended to be read, as it is modified by `mount` automatically.

Mount without arguments cats it:

    mount

`/proc/mounts` is generally better as it uses actual up-to-date kernel mount information. The formats are the same, and contents are likely to be very similar.

## Auto mount Windows filesystems

To mount Windows filesystems such as NTFS or DOS use:

    umask=111,dmask=000

This way, directories will be 000 and files 666 (not executable).

## DVD

Mounting DVDs / USBs is similar to mounting partitions:

    /dev/cdrom 	/media/dvd 	noauto 	ro 0 0

However if you use auto, you always get errors when the DVD is empty.

It is best to use auto, because DVD can be of several formats.

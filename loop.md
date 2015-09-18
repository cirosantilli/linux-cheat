# /dev/loop

# loop

# loop0

# loop1

Block device whose date is backed by a file.

Type, major, minor: block, 7, `X` for `/dev/loopX`

`loop` is a kernel module. Ubuntu 14.04 embeds it in the kernel.

Can be used to mount regular files that contain filesystems:

    dd if=/dev/zero of=a.ex2 bs=1024 count=64

    echo y | mke2fs -t ext2 a.ex2
    mkdir -p d
    sudo mount -o loop a.ex2 d
    # Do stuff. sudo needed: permissions for d change when mounted.
    echo a | sudo tee d/a
    sudo umount d

    mkdir -p e
    sudo mount -o loop a.ex2 e
    ls e
    sudo umount e

A less magical way to do `sudo mount a.ex2 d -o loop` is:

    losetup /dev/loop2 a.ex2
    sudo mount /dev/loop2 d

Or to avoid hardcoding it:

    loop="$(losetup -f --show a.ex2)"
    sudo mount "$loop" d

A common use case is to mount a file that is a backup dump from a partition, e.g.:

    dd if=/dev/sda5 of=a.img bs=1024
    sudo mount a.img d/

The image to be mounted must contain a single filesystem (partition). If you've dumped the entire hard disk, e.g. with:

    dd if=/dev/sda of=a.img bs=1024

it is not going to work. What to do in that case:

- <http://stackoverflow.com/questions/1419489/loopback-mounting-individual-partitions-from-within-a-file-that-contains-a-parti>
- <http://unix.stackexchange.com/questions/9099/reading-a-filesystem-from-a-whole-disk-image>
- <http://superuser.com/questions/117136/how-can-i-mount-a-partition-from-dd-created-image-of-a-block-device-e-g-hdd-u>
- <http://askubuntu.com/questions/69363/mount-single-partition-from-image-of-entire-disk-device>

## losetup

Associate loop devices with files.

TODO: what system call is used to implement it?

Loop devices know what file they point to. Make a given loop device point to a given file:

    losetup /dev/loop2 a.img

`--offset`: each loop device has an associated offset. If given, the device representing the file starts at a given offset within the file.

    losetup --offset 32256 /dev/loop2 harddrive.img

Application: mount a given partition of a filesystem. But this can now be done better with `-P`.

## /sys/module/loop/parameters/max_part

If !=0, this automatically creates one `loopXpY` device per partition when you `losetup`:

- <http://unix.stackexchange.com/questions/87183/creating-formatted-partition-from-nothing>
- <http://askubuntu.com/questions/333875/creating-filesystem-from-nothing>

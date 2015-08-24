# /dev/loop

# loop

# loop0

# loop1

Block device whose date is backed by a file.

Type, major, minor: block, 7, `X` for `/dev/loopX`

Can be used to mount regular files that contain filesystems:

    dd if=/dev/zero of=a.ex2 bs=1024 count=64
    echo y | mke2fs -t ext2 a.ex2
    mkdir -p d
    sudo mount a.ex2 d -o loop
    # Do stuff
    echo a > d/a
    sudo umount d

A less magical way to do `sudo mount a.ex2 d -o loop` is:

    losetup /dev/loop2 a.ex2
    sudo mount /dev/loop2 d

A common use case is to mount a file that is a backup dump from a partition, e.g.:

    dd if=/dev/sda5 of=a.img bs=1024
    sudo mount a.img d/

The image to be mounted must contain a single filesystem (partition). If you've dumped the entire hard disk, e.g. with:

    dd if=/dev/sda of=a.img bs=1024

it is not going to work. What to do in that case: <https://major.io/2010/12/14/mounting-a-raw-partition-file-made-with-dd-or-dd_rescue-in-linux/>

## losetup

Associate loop devices with files.

TODO: what system call is used to implement it?

Loop devices know what file they point to. Make a given loop device point to a given file:

    losetup /dev/loop2 a.img

`--offset`: each loop device has an associated offset. If given, the device representing the file starts at a given offset within the file.

    losetup --offset 32256 /dev/loop2 harddrive.img

Application: mount a given partition of a filesystem: <https://major.io/2010/12/14/mounting-a-raw-partition-file-made-with-dd-or-dd_rescue-in-linux/>

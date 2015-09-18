# mke2fs

Make ext[234] partitions.

Consider using gparted if you have X11.

## Erase everything in a disk and create a single ext4 partition on it

First we must destroy the partition table, and create a single partition.

Only then we can use `mke2fs` on the partition (`/dev/sdXY`).

You should *not* use `mke2fs` on the disk device directly (`/dev/sdX`).

    dev='/dev/sdX'
    sudo umount "$dev"
    printf "o\nn\np\n1\n\n\nw\n" | sudo fdisk "$dev"
    sudo mkfs.ext4 "${dev}1"
    mkdir -p d
    sudo mount "${dev}1" d
    ld d

## Create partition in a regular file

Great way to study how file systems work byte by byte.

ext2 needs at least 64k (TODO exact minimum?)

    F=a.ex2
    dd if=/dev/zero of="$F" bs=1024 count=64
    echo y | mke2fs -t ext2 "$F"
    mkdir -p d
    sudo mount "$F" d -o loop
    # Do stuff
    echo a > d/f
    sudo umount d

Now `file a.ex2` says:

    a.ex2: Linux rev 1.0 ext2 filesystem data, UUID=f2c40840-cf93-49d9-a3b7-353c8994ee46

## Command line options

- `-t`: type: ext2, ext3, ext4
- `-L`: label
- `-i`: inodes per group (power of 2)
- `-j`: use ext3 journaling. TODO for `-t` ext3/4, is it created by default?

## mkfs.ext3

## mkfs.ext4

Symlinks to `mke2fs`.

`man mke2fs` says it is the same as using `-t ext4`? `mke2fs` is able to differentiate them from `args[0]`, much like BusyBox I guess.

## mkfs.ext4dev

TODO? Vs `mkfs.ext4`?

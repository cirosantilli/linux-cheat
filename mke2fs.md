# mke2fs

Make ext[234] partitions.

Consider using gparted if you have X11.

- `-t`: type: ext2, ext3, ext4
- `-L`: label
- `-i`: inodes per group (power of 2)
- `-j`: use ext3 journaling. TODO for `-t` ext3/4, is it created by default?

## Create partition in a regular file

Great way to study how file systems work byte by byte.

ext2 needs at least 64k (TODO exact minimum).

    dd if=/dev/zero of=a.ex2 bs=1024 count=64
    echo y | mke2fs -t ext2 a.ex2
    mkdir -p d
    sudo mount a.ex2 d -o loop
    # Do stuff
    sudo umount d

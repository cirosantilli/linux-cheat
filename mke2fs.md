# mke2fs

Make ext[234] partitions.

Consider using gparted if you have X11.

- `-t`: type: ext2, ext3, ext4
- `-L`: label
- `-i`: inodes per group (power of 2)
- `-j`: use ext3 journaling. TODO for `-t` ext3/4, is it created by default?

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

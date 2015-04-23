# mke2fs

Make ext[234] partitions.

Consider using gparted if you have X11.

- `-t`: type: ext2, ext3, ext4
- `-L`: label
- `-i`: inodes per group (power of 2)
- `-j`: use ext3 journaling. TODO for `-t` ext3/4, is it created by default?

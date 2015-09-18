# fstab

This is about the `/etc/fstab` config file.

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

    It seems that fstab can auto create/remove the missing directories.

3.  Type. ext[234], NTFS, etc.

4.  Options.

    - `defaults`. Use default options for the current filesystem type.

5.  Dump. Used by the dump utility to make backups. If `0`, don't make backups. If `1`, make them.

6.  Pass. Used by `fsck`. If `0` the FS is ignored by `fsck`, `1` it is checked with highest priority, `2` checked with smaller priority.

Use 1 for the primary partition, `2` for the others.

# df

POSIX 7 <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/df.html>

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

Get the current partition for a given path:

    df /mnt/tmpfs

Sample output:

    Filesystem     1K-blocks  Used Available Use% Mounted on
    tmpfs             102400     0    102400   0% /mnt/tmpfs

## i

Get percentage of free / used inodes:

    df -i

Sample output:

    Filesystem    Inodes IUsed  IFree IUse% Mounted on
    /dev/sda5   22167552 832797 21334755  4% /
    /dev/sda2   30541336 189746 30351590  1% /media/win7

This is interesting because the number of inodes is a limitation of filesystems
in addition to the amount of data stored.

This limits the amount of files you can have on a system in case you have
lots of small files.

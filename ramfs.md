# ramfs

# tmpfs

Types of filesystems that exists only in RAM. It is therefore fast and can only be small. In the Linux kernel under `fs/ramfs`.

Can be useful if you want to speed up some filesystem operations and have enough RAM for it.

On Ubuntu 14.04, a `tmpfs` is mounted by default at `/run`, to which the FHS `/var/run` symlinks to.

## tmpfs vs ramfs

-   tmpfs has a fixed size: it does not grow dynamically and raises an error if you blow the limit.

    ramfs can grow dynamically and does not use swap.

-   tmpfs uses swap, ramfs does not.

## Create

Create a tmpfs:

    sudo mkdir -p /mnt/tmpfs
    sudo mount -t tmpfs -o size=100m tmpfs /mnt/tmpfs

Create a ramfs:

    sudo mkdir -p /mnt/ramfs
    sudo mount -t ramfs -o size=300m ramfs /mnt/ramfs

Undo with:

    sudo umount /mnt/ramfs

## Ubuntu 14.04 example

Ubuntu 14.04 has the following `tmpfs` by default:

    tmpfs /run tmpfs rw,nosuid,noexec,relatime,size=376744k,mode=755 0 0
    none /sys/fs/cgroup tmpfs rw,relatime,size=4k,mode=755 0 0
    none /run/lock tmpfs rw,nosuid,nodev,noexec,relatime,size=5120k 0 0
    none /run/shm tmpfs rw,nosuid,nodev,relatime 0 0
    none /run/user tmpfs rw,nosuid,nodev,noexec,relatime,size=102400k,mode=755 

`/run` is of course a good candidate to be `tmpfs`.

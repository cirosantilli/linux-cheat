# ramfs

# tmpfs

Types of filesystems that exists only in RAM. It is therefore fast and can only be small. In the Linux kernel under `fs/ramfs`.

Can be useful if you want to speed up some filesystem operations and have enough RAM for it.

tmpfs vs ramfs:

-   tmpfs has a fixed size: it does not grow dynamically and raises an error if you blow the limit.

    ramfs can grow dynamically and does not use swap.

-   tmpfs uses swap, ramfs does not.

Create a tmpfs:

    sudo mkdir -p /mnt/tmpfs
    sudo mount -t tmpfs -o size=100m tmpfs /mnt/tmpfs

Create a ramfs:

    sudo mkdir -p /mnt/ramfs
    sudo mount -t ramfs -o size=100m ramfs /mnt/ramfs

Undo with:

    sudo umount /mnt/ramfs

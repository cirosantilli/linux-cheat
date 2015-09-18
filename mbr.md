# MBR

<https://en.wikipedia.org/wiki/Master_boot_record>

<https://wiki.archlinux.org/index.php/Master_Boot_Record>

You can only have 4 primary partitions.

Each one can be either divided into logical any number of logical partitions partitions.

A primary partition that is split into logical partitions is called an extended partition.

Primary partitions get numbers from 1 to 4.

Logical partitions get numbers starting from 5.

You can visualize which partition is inside which disk with `sudo lsblk -l`.

TODO more common?

The MBR is the first 512 sector of the device found. It contains:

-   a small piece of code (446 bytes) called the primary boot loader.

    This code will then be executed.

    Most often, all it does it to load a second stage bootloader like GRUB.

-   the partition table (64 bytes) describing the primary and extended partitions.

-   2 bytes for MBR validation check.

    It is a fixed magic number <http://stackoverflow.com/questions/1125025/what-is-the-role-of-magic-number-in-boot-loading-in-linux>, that can be used to:

    - check if the device has a MBR
    - check endianess

The MBR can only be at the start of a physical partition, not of a logical partition.

This is why on bootloader configurations you give `/dev/sda`, instead of `/dev/sda1-4`.

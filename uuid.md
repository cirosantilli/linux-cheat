# UUID

Unique identifier for a partition. Concept exists in both ext and NTFS.

Given when you create of format a partition.

Can be found with tools such as `lsblk -o`, `blkid`, or `gparted`.

Get UUID of a device:

    sudo lsblk -no UUID /dev/sda1

Get all devices:

    sudo lsblk -no UUID /dev/sda1

An ext partitions concept.

Determines the mount name for the partition.

Should be unique, but not sure this is enforced. TODO

# fdisk

View and edit partition tables and disk parameters.

Mnemonic: Format disk.

util-linux package.

REPL interface. Non-interactive usage only with pipes... <http://superuser.com/questions/332252/creating-and-formating-a-partition-using-a-bash-script>

Does not create filesystems. For that see: `mke2fs` for ext systems.

Better use gparted for simple operations if you have X11

To view/edit partitions with interactive CLI prompt interface.

## l

Show lots of partition and disk data on all disks:

    sudo fdisk -l

Sample output for each disk:

    Disk /dev/sda: 500.1 GB, 500107862016 bytes
    255 heads, 63 sectors/track, 60801 cylinders, total 976773168 sectors
    Units = sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 4096 bytes
    I/O size (minimum/optimal): 4096 bytes / 4096 bytes
    Disk identifier: 0x7ddcbf7d

    Device Boot   Start     End   Blocks  Id System
    /dev/sda1  *    2048   3074047   1536000  7 HPFS/NTFS/exFAT
    /dev/sda2     3074048  198504152  97715052+  7 HPFS/NTFS/exFAT
    /dev/sda3    948099072  976771071  14336000  7 HPFS/NTFS/exFAT
    /dev/sda4    198504446  948099071  374797313  5 Extended
    Partition 4 does not start on physical sector boundary.
    /dev/sda5    198504448  907638783  354567168  83 Linux
    /dev/sda6    940277760  948099071   3910656  82 Linux swap / Solaris
    /dev/sda7    907640832  940267519  16313344  83 Linux

TODO: what is the `boot` column?

## REPL

Edit partitions for `sdb` on REPL interface:

    sudo fdisk /dev/sdb

Operation: make a list of changes to be made, then write them all to disk and exit with `w` (write).

Most useful commands:

- `m`: list options
- `p`: print info on partition, same as using `-l` option
- `o`: create new DOS partition table
- `n`: create new partition
- `d`: delete a partition
- `w`: write enqueued changes and exit

## Erase everything and create a single partition

    printf 'o\nn\np\n1\n\n\nw\n' | sudo fdisk /dev/sdX

This does not create a filesystem, only the partition.

The one partition takes up almost the entire disk, except the first 2048 bytes which are reserved for the partition table.

TODO: why does it leave 2048 and not just 512 which is what the MBR needs?

You will now likely want to use `mke2fs` to create a partition like:

    sudo mkfs.ext4 /dev/sdX1

## Minimal size for a partition

### Why fails for small images?

TODO <http://superuser.com/questions/972433/why-does-fdisk-fail-to-create-a-new-partition-with-you-must-set-cylinders-if>

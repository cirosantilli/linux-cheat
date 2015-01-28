# lsblk

List block devices, including those which are not mounted.

    sudo lsblk

Sample output:

    NAME    MAJ:MIN RM  SIZE   RO TYPE MOUNTPOINT
    sda     8:0     0   465.8G 0  disk
    |-sda1  8:1     0    1.5G  0  part
    |-sda2  8:2     0   93.2G  0  part /media/win7
    |-sda3  8:3     0   13.7G  0  part
    |-sda4  8:4     0     1K   0  part
    |-sda5  8:5     0   338.1G 0  part /
    |-sda6  8:6     0    3.7G  0  part [SWAP]
    `-sda7  8:7     0   15.6G  0  part
    sdb     8:16    0   931.5G 0  disk
    `-sdb1  8:17    0   931.5G 0  part /media/ciro/DC74FA7274FA4EB0

`-f`: show mostly information on filesystems:

    sudo lsblk -f

Sample output:

    NAME  FSTYPE LABEL      MOUNTPOINT
    sda
    |-sda1 ntfs  SYSTEM_DRV
    |-sda2 ntfs  Windows7_OS   /media/win7
    |-sda3 ntfs  Lenovo_Recovery
    |-sda4
    |-sda5 ext4          /
    |-sda6 swap          [SWAP]
    `-sda7 ext4
    sdb
    `-sdb1 ntfs          /media/ciro/DC74FA7274FA4EB0

`-o`: select which columns you want exactly. Most useful information for humans:

    sudo lsblk -o NAME,FSTYPE,MOUNTPOINT,LABEL,UUID,SIZE

`-n`: don't output header with column names. Good way to get information computationally. E.g., get UUID of `/dev/sda1`:

    sudo lsblk -no UUID /dev/sda1

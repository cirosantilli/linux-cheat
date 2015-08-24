# parted

Get information on all partitions

Very useful output form:

    sudo parted -l

Sample output:

    Number Start  End   Size  Type   File system   Flags
    1   1049kB 1574MB 1573MB primary  ntfs      boot
    2   1574MB 102GB  100GB  primary  ntfs
    4   102GB  485GB  384GB  extended
    5   102GB  465GB  363GB  logical  ext4
    7   465GB  481GB  16.7GB logical  ext4
    6   481GB  485GB  4005MB logical  linux-swap(v1)
    3   485GB  500GB  14.7GB primary  ntfs

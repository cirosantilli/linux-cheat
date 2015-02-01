# Swap partition

The swap partition is used by OS to store RAM that is not being used at the moment to make room for more RAM.

Should be as large as your RAM more or less, or twice it.

Can be shared by multiple OS, since only one OS can run at a time.

## mkswap

`util-linux` package.

Make swap partition on a file in local filesystem:

    sudo dd if=/dev/zero of=/swapfile bs=1024 count=1024k
    sudo mkswap /swapfile
    sudo swapon /swapfile

For that to work every time:

    sudo bash -c 'echo "/swapfile    none  swap  sw   0    0" >> /etc/fstab'

## swapon

Turn swap on on partition `/dev/sda7`:

    sudo swapon /dev/sda7

Find the currently used swap partition:

    swapon -s

## swapoff

Disable swapping:

    sudo swapoff

---

Make a swap partition on partition with random UUID.

    sudo mkswap -U random /dev/sda7

Swap must be off.

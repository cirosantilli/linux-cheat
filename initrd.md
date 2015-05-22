# initrd TODO

Used by the boot system.

Seems to be the first filesystem that gets mounted by the kernel, a RAM fs here. The kernel then executes the `/init` script.

It is then the job of this script to mount the real physical filesystem.

On Ubuntu 14.04, it appears at:

    /boot/initrd.img-<version>

TODO how is it selected between all other `initrd`? Also, no package owns that file, so it must be generated at boot time every time?

It is a gzipped cpio archive.

Minimal Linux Live generates it with:

    find . | cpio -H newc -o | gzip > ../initrd.cpio.gz

where `../rootfs.cpio.gz` is the root filesystem to be used.

It can then be passed to QEMU as:

You can unwrap it with:

    gunzip <initrd.img | cpio -i

On Ubuntu 14.04, it appears to contain a minimal system including `busybox`.

## /dev/initrd

TODO

## initramfs

<http://stackoverflow.com/questions/10603104/the-difference-between-initrd-and-initramfs>

<https://wiki.ubuntu.com/Initramfs>

### update-initramfs

`initramfs-tools` package in Ubuntu 14.04.

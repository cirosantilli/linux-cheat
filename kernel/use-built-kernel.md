# Use built kernel

So you've built the kernel. Now what can you do with it?

The main missing ingredient now is a root filesystem.

Some options:

- <https://github.com/ivandavidov/minimal>. Educational mostly. BusyBox + glibc init and shell, syslinux bootloader, no GCC cross compile.
- <https://buildroot.org/>. Professional stuff.

## make isoimage

For x86 (TODO why only x86?), you can generate a bootable ISO with:

    make isoimage FDINITRD=rootfs.cpio.gz

where `FINITRD` points to a previously constructed `initrd` that will be used to initialize the system.

This was used by [Minimal Linux Live](https://github.com/ivandavidov/minimal), which produces a nice little `rootfs.cpio.gz` with BusyBox.

The output file generated is:

    build/arch/x86/boot/image.iso

You can then feed the generated ISO directly to QEMU with either:

    qemu-system-x86_64 -cdrom image.iso
    qemu-system-x86_64 -hda image.iso

or burn it to either an USB or CD with:

    sudo dd if=image.iso of=/dev/sdX

Internally in 4.2, it is coded at `arch/x86/boot/Makefile`, and `syslinux`, `mkisofs` to make a ISO, and then `isohybrid` to make it bootable either from ISO or USB.

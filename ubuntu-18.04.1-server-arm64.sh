#!/usr/bin/env bash
set -eu

# TODO not working. Tested on host: Ubuntu 18.10.
# GRUB shows on terminal, but then after language selection,
# it hangs for a while, and then finally says:
#
# > Detect and mount CD-ROM
# >
# > Your installation CD-ROM couldn't be mounted. This probably means
# > that the CD-ROM was not in the drive. If so you can insert it and try
# > again.
# >
# > Retry mounting the CD-ROM?
#
# - https://superuser.com/questions/942657/how-to-test-arm-ubuntu-under-qemu-the-easiest-way
# - https://askubuntu.com/questions/797599/how-to-run-ubuntu-16-04-arm-in-qemu

# Parameters.
id=ubuntu-18.04.1-server-arm64
#id=debian-9.6.0-arm64-xfce-CD-1
img="${id}.img.qcow2"
iso="${id}.iso"
flash0="${id}-flash0.img"
flash1="${id}-flash1.img"

# Images.
if [ ! -f "$iso" ]; then
  wget "http://cdimage.ubuntu.com/releases/18.04/release/${iso}"
fi
if [ ! -f "$img" ]; then
  qemu-img create -f qcow2 "$img" 1T
fi
if [ ! -f "$flash0" ]; then
  dd if=/dev/zero of="$flash0" bs=1M count=64
  dd if=/usr/share/qemu-efi/QEMU_EFI.fd of="$flash0" conv=notrunc
fi
if [ ! -f "$flash1" ]; then
  dd if=/dev/zero of="$flash1" bs=1M count=64
fi

# Run.
# TODO where to put this?
#-drive "file=${img},format=qcow2" \
qemu-system-aarch64 \
  -cdrom "$iso" \
  -cpu cortex-a57 \
  -device rtl8139,netdev=net0 \
  -m 2G \
  -machine virt \
  -netdev user,id=net0 \
  -nographic \
  -pflash "$flash0" \
  -pflash "$flash1" \
;

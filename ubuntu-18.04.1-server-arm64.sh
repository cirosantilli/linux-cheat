#!/usr/bin/env bash

set -eux

# Tested on host: Ubuntu 18.04 arm64 with -enable-kvm.
#
# TODO: on Ubuntu 18.10 amd64 host, installer step "Select and install software" fails.
# Where can I find logs saying exactly what failed?
#
# - https://superuser.com/questions/942657/how-to-test-arm-ubuntu-under-qemu-the-easiest-way
# - https://askubuntu.com/questions/797599/how-to-run-ubuntu-16-04-arm-in-qemu

# Parameters.
id=ubuntu-18.04.1-server-arm64
#id=debian-9.6.0-arm64-xfce-CD-1
img="${id}.img.qcow2"
img_snapshot="${id}.img.snapshot.qcow2"
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
if [ ! -f "$img_snapshot" ]; then
  qemu-img \
    create \
    -b "$img" \
    -f qcow2 \
    "$img_snapshot" \
  ;
fi
if [ ! -f "$flash0" ]; then
  dd if=/dev/zero of="$flash0" bs=1M count=64
  dd if=/usr/share/qemu-efi/QEMU_EFI.fd of="$flash0" conv=notrunc
fi
if [ ! -f "$flash1" ]; then
  dd if=/dev/zero of="$flash1" bs=1M count=64
fi

# Run.
#
# cdrom must be scsi or else the installation fails midway with:
#
# > Detect and mount CD-ROM
# >
# > Your installation CD-ROM couldn't be mounted. This probably means
# > that the CD-ROM was not in the drive. If so you can insert it and try
# > again.
# >
# > Retry mounting the CD-ROM?
# > Your installation CD-ROM couldn't be mounted.
#
# This is because the drivers for the default virtio are not installed in the ISO,
# because in the past it was not reliable on qemu-system-aarch64.
#
# See also:
# https://bazaar.launchpad.net/~ubuntu-testcase/ubuntu-manual-tests/trunk/view/head:/testcases/image/1688_ARM64_Headless_KVM_Guest
qemu-system-aarch64 \
  -cpu cortex-a57 \
  -device rtl8139,netdev=net0 \
  -device virtio-scsi-device \
  -device scsi-cd,drive=cdrom \
  -device virtio-blk-device,drive=hd0 \
  -drive "file=${iso},id=cdrom,if=none,media=cdrom" \
  -drive "if=none,file=${img_snapshot},id=hd0" \
  -m 2G \
  -machine virt \
  -netdev user,id=net0 \
  -nographic \
  -pflash "$flash0" \
  -pflash "$flash1" \
  -smp 2 \
  "$@" \
;

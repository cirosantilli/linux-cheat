#!/usr/bin/env bash

# Tested on: Ubuntu 18.10.
# https://askubuntu.com/questions/884534/how-to-run-ubuntu-16-04-desktop-on-qemu/1046792#1046792

set -eux

# Parameters.
id=ubuntu-18.04.1-desktop-amd64
disk_img="${id}.img.qcow2"
disk_img_snapshot="${id}.snapshot.qcow2"
iso="${id}.iso"

# Images.
if [ ! -f "$iso" ]; then
  wget "http://releases.ubuntu.com/18.04/${iso}"
fi
if [ ! -f "$disk_img" ]; then
  qemu-img create -f qcow2 "$disk_img" 1T
  qemu-system-x86_64 \
    -cdrom "$iso" \
    -drive "file=${disk_img},format=qcow2" \
    -enable-kvm \
    -m 2G \
    -smp 2 \
  ;
fi

if [ ! -f "$disk_img_snapshot" ]; then
  qemu-img \
    create \
    -b \
    -f qcow2 \
    "$disk_img" \
    "$disk_img_snapshot" \
  ;
fi

qemu-system-x86_64 \
  -drive file=ubuntu-18.04-desktop-amd64.snapshot.qcow2,format=qcow2 \
  -enable-kvm \
  -m 2G \
  -smp 2 \
  -soundhw hda \
  -vga virtio \
;

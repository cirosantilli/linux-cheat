#!/usr/bin/env bash
set -eu
# Tested on host: Ubuntu 18.10.
# TODO: get working without GUI:
# https://askubuntu.com/questions/1108334/how-to-boot-and-install-the-ubuntu-server-image-on-qemu-nographic-without-the-g
id=ubuntu-18.04.1.0-live-server-amd64
iso="${id}.iso"
img="${id}.img.qcow2"
if [ ! -f "$iso" ]; then
  wget "http://releases.ubuntu.com/18.04/${iso}"
fi
if [ ! -f "$img" ]; then
  qemu-img create -f qcow2 "$img" 1T
fi
qemu-system-x86_64 \
  -cdrom "$iso" \
  -drive "file=${img},format=qcow2" \
  -enable-kvm \
  -m 2G \
  -serial mon:stdio \
  -smp 2 \
  -vga virtio \
  "$@" \
;

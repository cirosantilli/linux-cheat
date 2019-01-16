#!/usr/bin/env bash

set -eux

# Parameters.
id=ubuntu-18.04-server-cloudimg-arm64
img="${id}.img"
img_snapshot="${id}.img.snapshot.qcow2"
flash0="${id}-flash0.img"
flash1="${id}-flash1.img"
user_data="${id}-user-data"
user_data_img="${user_data}.img"

# Install dependencies.
pkgs='cloud-image-utils qemu-system-arm qemu-efi'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install $pkgs
fi

# Get the image.
if [ ! -f "$img" ]; then
  wget "https://cloud-images.ubuntu.com/releases/18.04/release/${img}"
fi

# Create snapshot.
if [ ! -f "$img_snapshot" ]; then
  qemu-img \
    create \
    -b "$img" \
    -f qcow2 \
    "$img_snapshot" \
    1T \
  ;
fi

# Set the password.
if [ ! -f "$user_data" ]; then
  cat >"$user_data" <<EOF
#cloud-config
password: asdfqwer
chpasswd: { expire: False }
ssh_pwauth: True
EOF
  cloud-localds "$user_data_img" "$user_data"
fi

# Firmware.
if [ ! -f "$flash0" ]; then
  dd if=/dev/zero of="$flash0" bs=1M count=64
  dd if=/usr/share/qemu-efi/QEMU_EFI.fd of="$flash0" conv=notrunc
fi
if [ ! -f "$flash1" ]; then
  dd if=/dev/zero of="$flash1" bs=1M count=64
fi

# Run.
qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a57 \
  -device rtl8139,netdev=net0 \
  -device virtio-blk-device,drive=hd0 \
  -drive "if=none,file=${img_snapshot},id=hd0" \
  -drive "file=${user_data_img},format=raw" \
  -m 2G \
  -netdev user,id=net0 \
  -nographic \
  -pflash "$flash0" \
  -pflash "$flash1" \
  -smp 2 \
;

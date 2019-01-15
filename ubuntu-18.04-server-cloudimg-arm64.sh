#!/usr/bin/env bash

set -eux

# Parameters.
id=ubuntu-18.04-server-cloudimg-arm64
img="${id}.img"
flash0="${id}-flash0.img"
flash1="${id}-flash1.img"
user_data="${id}-user-data.img"

# Install dependencies.
pkgs='cloud-image-utils qemu-system-arm qemu-efi'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install $pkgs
fi

# Get the image.
if [ ! -f "$img" ]; then
  wget "https://cloud-images.ubuntu.com/releases/18.04/release/${img}"
  qemu-img resize "$img" +128G
fi

# For the password.
if [ ! -f "$user_data" ]; then
  cat >user-data <<EOF
#cloud-config
password: asdfqwer
chpasswd: { expire: False }
ssh_pwauth: True
EOF
  cloud-localds "$user_data" user-data
fi
if [ ! -f "$flash0" ]; then
  dd if=/dev/zero of="$flash0" bs=1M count=64
  dd if=/usr/share/qemu-efi/QEMU_EFI.fd of="$flash0" conv=notrunc
fi
if [ ! -f "$flash1" ]; then
  dd if=/dev/zero of="$flash1" bs=1M count=64
fi

# Run.
qemu-system-aarch64 \
  -cpu cortex-a57 \
  -device rtl8139,netdev=net0 \
  -device virtio-blk-device,drive=hd0 \
  -drive "file=${user_data},format=raw" \
  -drive "if=none,file=${img},id=hd0" \
  -m 2G \
  -machine virt \
  -netdev user,id=net0 \
  -nographic \
  -pflash "$flash0" \
  -pflash "$flash1" \
;

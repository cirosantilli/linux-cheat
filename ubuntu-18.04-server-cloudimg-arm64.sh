#!/usr/bin/env bash

set -eux

# Parameters.
img=ubuntu-18.04-server-cloudimg-arm64.img

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
user_data=user-data.img
if [ ! -f "$user_data" ]; then
  cat >user-data <<EOF
#cloud-config
password: asdfqwer
chpasswd: { expire: False }
ssh_pwauth: True
EOF
  cloud-localds "$user_data" user-data

  # Use the EFI magic. Picked up from:
  # https://wiki.ubuntu.com/ARM64/QEMU
  dd if=/dev/zero of=flash0.img bs=1M count=64
  dd if=/usr/share/qemu-efi/QEMU_EFI.fd of=flash0.img conv=notrunc
  dd if=/dev/zero of=flash1.img bs=1M count=64
fi

# Run.
qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a57 \
  -device rtl8139,netdev=net0 \
  -m 4096 \
  -netdev user,id=net0 \
  -nographic \
  -smp 4 \
  -drive "if=none,file=${img},id=hd0" \
  -device virtio-blk-device,drive=hd0 \
  -drive "file=${user_data},format=raw" \
  -pflash flash0.img \
  -pflash flash1.img \
;

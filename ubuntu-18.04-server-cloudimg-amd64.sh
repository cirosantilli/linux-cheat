#!/usr/bin/env bash

# Tested on host: Ubuntu 18.10.

set -eux

# Parameters.
id=ubuntu-18.04-server-cloudimg-amd64
img="${id}.img"
img_snapshot="${id}.img.snapshot.qcow2"
user_data="${id}-user-data"
user_data_img="${user_data}.img"

# Install dependencies.
pkgs='cloud-image-utils qemu'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install $pkgs
fi

# Get the image.
if [ ! -f "$img" ]; then
  wget "https://cloud-images.ubuntu.com/releases/18.04/release/${img}"
fi

# Create snapshot.
if [ ! -f "$img_snapshot" ]; then
  # 1T does a sparse resize: does not use any extra space, just allows the resize to happen later on.
  # https://superuser.com/questions/1022019/how-to-increase-size-of-an-ubuntu-cloud-image
  qemu-img \
    create \
    -b "$img" \
    -f qcow2 \
    "$img_snapshot" \
    1T \
  ;
fi

# Set the password.
# https://serverfault.com/questions/920117/how-do-i-set-a-password-on-an-ubuntu-cloud-image
# https://askubuntu.com/questions/507345/how-to-set-a-password-for-ubuntu-cloud-images-ie-not-use-ssh
if [ ! -f "$user_data" ]; then
  cat >"$user_data" <<EOF
#cloud-config
password: asdfqwer
chpasswd: { expire: False }
ssh_pwauth: True
EOF
  cloud-localds "$user_data_img" "$user_data"
fi

# Run. The first boot will spend some time generating keys
# on "cloud-init job", but further boots will be faster.
qemu-system-x86_64 \
  -drive "file=${img_snapshot},format=qcow2" \
  -drive "file=${user_data_img},format=raw" \
  -device rtl8139,netdev=net0 \
  -enable-kvm \
  -m 2G \
  -netdev user,id=net0 \
  -serial mon:stdio \
  -smp 2 \
  "$@" \
;

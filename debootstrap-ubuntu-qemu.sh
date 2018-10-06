#!/usr/bin/env bash

# https://askubuntu.com/questions/281763/is-there-any-prebuilt-qemu-ubuntu-image32bit-online/1081171#1081171

set -eux

debootstrap_dir=debootstrap
root_filesystem=debootstrap.ext2.qcow2

sudo apt-get install \
  debootstrap \
  libguestfs-tools \
  qemu-system-x86 \
;

if [ ! -d "$debootstrap_dir" ]; then
  # Create debootstrap directory.
  # - linux-image-generic: downloads the kernel image we will use under /boot
  # - network-manager: automatically starts the network at boot for us
  sudo debootstrap \
    --include linux-image-generic \
    bionic \
    "$debootstrap_dir" \
    http://archive.ubuntu.com/ubuntu \
  ;
  sudo rm -f "$root_filesystem"
fi

linux_image="$(printf "${debootstrap_dir}/boot/vmlinuz-"*)"

if [ ! -f "$root_filesystem" ]; then
  # Set root password.
  echo 'root:root' | sudo chroot "$debootstrap_dir" chpasswd

  # Remount root filesystem as rw.
  cat << EOF | sudo tee "${debootstrap_dir}/etc/fstab"
/dev/sda / ext4 errors=remount-ro,acl 0 1
EOF

  # Automaticaly start networking.
  # Otherwise network commands fail with:
  #     Temporary failure in name resolution
  # https://askubuntu.com/questions/1045278/ubuntu-server-18-04-temporary-failure-in-name-resolution/1080902#1080902
  cat << EOF | sudo tee "$debootstrap_dir/etc/systemd/system/dhclient.service"
[Unit]
Description=DHCP Client
Documentation=man:dhclient(8)
Wants=network.target
Before=network.target
[Service]
Type=forking
PIDFile=/var/run/dhclient.pid
ExecStart=/sbin/dhclient -4 -q
[Install]
WantedBy=multi-user.target
EOF
  sudo ln -sf "$debootstrap_dir/etc/systemd/system/dhclient.service" \
    "${debootstrap_dir}/etc/systemd/system/multi-user.target.wants/dhclient.service"

  # Why Ubuntu, why.
  # https://bugs.launchpad.net/ubuntu/+source/linux/+bug/759725
  sudo chmod +r "${linux_image}"

  # Generate image file from debootstrap directory.
  # Leave 1Gb extra empty space in the image.
  sudo virt-make-fs \
    --format qcow2 \
    --size +1G \
    --type ext2 \
    "$debootstrap_dir" \
    "$root_filesystem" \
  ;
  sudo chmod 666 "$root_filesystem"
fi

qemu-system-x86_64 \
  -append 'console=ttyS0 root=/dev/sda' \
  -drive "file=${root_filesystem},format=qcow2" \
  -enable-kvm \
  -serial mon:stdio \
  -m 2G \
  -kernel "${linux_image}" \
  -device rtl8139,netdev=net0 \
  -netdev user,id=net0 \
;

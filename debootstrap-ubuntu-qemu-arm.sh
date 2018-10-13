#!/usr/bin/env bash

# https://askubuntu.com/questions/281763/is-there-any-prebuilt-qemu-ubuntu-image32bit-online/1081171#1081171

set -eux

debootstrap_dir=debootstrap
root_filesystem=debootstrap.ext2.qcow2

sudo apt-get install \
  gcc-aarch64-linux-gnu \
  debootstrap \
  libguestfs-tools \
  qemu-system-aarch64 \
  qemu-user-static \
;

if [ ! -d "$debootstrap_dir" ]; then
  sudo debootstrap \
    --arch arm64 \
    --foreign \
    bionic \
    "$debootstrap_dir" \
    http://ports.ubuntu.com/ubuntu-ports \
  ;
  sudo mkdir -p "${debootstrap_dir}/usr/bin"
  sudo cp "$(which qemu-aarch64-static)" "${debootstrap_dir}/usr/bin"
  sudo chroot "$debootstrap_dir" /debootstrap/debootstrap --second-stage
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
  cat << EOF | sudo tee "${debootstrap_dir}/etc/systemd/system/dhclient.service"
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
  sudo ln -sf "${debootstrap_dir}/etc/systemd/system/dhclient.service" \
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

# Build the Linux kernel.
linux_image="$(pwd)/linux/debian/build/build-generic/arch/arm64/boot/Image"
if [ ! -f "$linux_image" ]; then
  git clone --branch Ubuntu-4.15.0-20.21 --depth 1 git://kernel.ubuntu.com/ubuntu/ubuntu-bionic.git linux
  cd linux
  patch -p1 << EOF
diff --git a/debian.master/config/config.common.ubuntu b/debian.master/config/config.common.ubuntu
index 5ff32cb997e9..8a190d3a0299 100644
--- a/debian.master/config/config.common.ubuntu
+++ b/debian.master/config/config.common.ubuntu
@@ -10153,7 +10153,7 @@ CONFIG_VIDEO_ZORAN_ZR36060=m
 CONFIG_VIPERBOARD_ADC=m
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_BALLOON=y
-CONFIG_VIRTIO_BLK=m
+CONFIG_VIRTIO_BLK=y
 CONFIG_VIRTIO_BLK_SCSI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_VIRTIO_INPUT=m
EOF
  export ARCH=arm64
  export $(dpkg-architecture -aarm64)
  export CROSS_COMPILE=aarch64-linux-gnu-
  fakeroot debian/rules clean
  debian/rules updateconfigs
  fakeroot debian/rules DEB_BUILD_OPTIONS=parallel=`nproc` build-generic
  cd -
fi

qemu-system-aarch64 \
  -append 'console=ttyAMA0 root=/dev/vda rootfstype=ext2' \
  -device rtl8139,netdev=net0 \
  -drive "file=${root_filesystem},format=qcow2" \
  -kernel "${linux_image}" \
  -m 2G \
  -netdev user,id=net0 \
  -serial mon:stdio \
  -M virt,highmem=off \
  -cpu cortex-a57 \
  -nographic \
;

#!/usr/bin/env bash

# On Ubuntu 18.04, Linux kernel 18.04, the third mount fails with:
#
#     wrong fs type, bad option, bad superblock on none, missing codepage or helper program, or other error.
#
# and dmesg contains:
#
#     overlayfs: maximum fs stacking depth exceeded
#
# Layer 2 works normally however.
#
# - https://stackoverflow.com/questions/31044982/how-to-use-multiple-lower-layers-in-overlayfs
# - https://unix.stackexchange.com/questions/341138/can-overlayfs-support-more-than-two-layers
# - https://askubuntu.com/questions/143176/overlayfs-reload-with-multiple-layers-migration-away-from-aufs

set -eux
top=overlayfs-multi.tmp
rm -rf "$top"
mkdir -p "$top"
cd "$top"
mkdir \
  lower \
  upper1 \
  upper2 \
  upper3 \
  overlay1 \
  overlay2 \
  overlay3 \
;
dd if=/dev/zero of=lower.ext2 bs=1024 count=102400
mkfs -t ext2 lower.ext2
cp lower.ext2 upper1.ext2
cp lower.ext2 upper2.ext2
cp lower.ext2 upper3.ext2
sudo mount lower.ext2 lower
sudo mount upper1.ext2 upper1
sudo mount upper2.ext2 upper2
sudo mount upper3.ext2 upper3
sudo chown "$USER:$USER" \
  lower \
  upper1 \
  upper2 \
  upper3 \
;
mkdir \
  upper1/upper1 \
  upper1/work1 \
  upper2/upper2 \
  upper2/work2 \
  upper3/upper3 \
  upper3/work3 \
;
printf 'lower-content' > lower/lower-file
printf 'upper-content' > upper1/upper1/upper-file-1
printf 'upper-content2' > upper2/upper2/upper-file-2
printf 'upper-content3' > upper3/upper3/upper-file-3
sudo mount \
  -t overlay \
  -o lowerdir=lower,upperdir=upper1/upper1,workdir=upper1/work1 \
  none \
  overlay1 \
;
sudo mount \
  -t overlay \
  -o lowerdir=overlay1,upperdir=upper2/upper2,workdir=upper2/work2 \
  none \
  overlay2 \
;
sudo mount \
  -t overlay \
  -o lowerdir=overlay2,upperdir=upper3/upper3,workdir=upper3/work3 \
  none \
  overlay3 \
;
printf 'overlay-content' > overlay1/overlay-file-1
printf 'overlay-content' > overlay2/overlay-file-2
printf 'overlay-content' > overlay3/overlay-file-3
ls \
  lower \
  upper1/upper1 \
  upper1/work1 \
  upper2/upper2 \
  upper2/work2 \
  overlay \
  overlay2 \
;
sudo umount overlay3 overlay2 overlay
ls \
  lower \
  upper/upper \
  upper/work \
  upper2/upper2 \
  upper2/work2 \
;
sudo umount upper2 upper lower

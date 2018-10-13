#!/usr/bin/env bash

# On Ubuntu 18.04, Linux kernel 18.04, if you run as:
#
#     ./overlayfs-multi-upper.sh 1
#
# then the third mount fails with:
#
#     wrong fs type, bad option, bad superblock on none, missing codepage or helper program, or other error.
#
# and dmesg contains:
#
#     overlayfs: maximum fs stacking depth exceeded
#
# The kernel cannot handle more than 2 overlayfs in daisy chain.
#
# Layer 2 works normally however.

set -eux
if [ $# -gt 0 ]; then
  layer3=true
else
  layer3=false
fi
top=overlayfs-multi-upper.tmp
rm -rf "$top"
mkdir -p "$top"
cd "$top"
dd if=/dev/zero of=lower.ext4 bs=1024 count=102400
mkfs -t ext4 lower.ext4
cp lower.ext4 upper1.ext4
cp lower.ext4 upper2.ext4
cp lower.ext4 upper3.ext4
sudo mount lower.ext4 lower
sudo mount upper1.ext4 upper1
sudo mount upper2.ext4 upper2
sudo mount upper3.ext4 upper3
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
printf 'upper-content-1' > upper1/upper1/upper-file-1
printf 'upper-content-2' > upper2/upper2/upper-file-2
printf 'upper-content-3' > upper3/upper3/upper-file-3
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
if "$layer3"; then
  sudo mount \
    -t overlay \
    -o lowerdir=overlay2,upperdir=upper3/upper3,workdir=upper3/work3 \
    none \
    overlay3 \
  ;
fi
printf 'overlay-content' > overlay1/overlay-file-1
printf 'overlay-content' > overlay2/overlay-file-2
printf 'overlay-content' > overlay3/overlay-file-3
ls \
  lower \
  upper1/upper1 \
  upper1/work1 \
  upper2/upper2 \
  upper2/work2 \
  overlay1 \
  overlay2 \
  overlay3 \
;
if "$layer3"; then
  sudo umount overlay3
fi
sudo umount overlay2 overlay1
ls \
  lower \
  upper1/upper1 \
  upper1/work1 \
  upper2/upper2 \
  upper2/work2 \
  upper3/upper3 \
  upper3/work3 \
;
sudo umount upper3 upper2 upper1 lower

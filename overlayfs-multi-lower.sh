#!/usr/bin/env bash

# Multiple lowers works fine, but not uppers are more limited: overlayfs-multi-upper.sh.
#
# - https://stackoverflow.com/questions/31044982/how-to-use-multiple-lower-layers-in-overlayfs
# - https://unix.stackexchange.com/questions/341138/can-overlayfs-support-more-than-two-layers
# - https://askubuntu.com/questions/143176/overlayfs-reload-with-multiple-layers-migration-away-from-aufs

set -eux
top=overlayfs-multi-lower.tmp
rm -rf "$top"
mkdir -p "$top"
cd "$top"
dd if=/dev/zero of=lower1.ext4 bs=1024 count=102400
mkfs -t ext4 lower1.ext4
cp lower1.ext4 lower2.ext4
cp lower1.ext4 lower3.ext4
cp lower1.ext4 upper.ext4
mkdir \
  lower1 \
  lower2 \
  lower3 \
  upper \
  overlay \
;
sudo mount lower1.ext4 lower1
sudo mount lower2.ext4 lower2
sudo mount lower3.ext4 lower3
sudo mount upper.ext4 upper
sudo chown "$USER:$USER" \
  lower1 \
  lower2 \
  lower3 \
  upper \
;
mkdir \
  upper/upper \
  upper/work \
;
printf 'lower-content-1' > lower1/lower-file-1
printf 'lower-content-2' > lower2/lower-file-2
printf 'lower-content-3' > lower3/lower-file-3
printf 'upper-content' > upper/upper/upper-file
sudo mount \
  -t overlay \
  -o lowerdir=lower1:lower2:lower3,upperdir=upper/upper,workdir=upper/work \
  none \
  overlay \
;
ls \
  lower1 \
  lower2 \
  lower3 \
  upper/upper \
  upper/work \
  overlay \
;
sudo umount overlay
ls \
  lower1 \
  lower2 \
  lower3 \
  upper/upper \
  upper/work \
;
sudo umount upper lower3 lower2 lower1

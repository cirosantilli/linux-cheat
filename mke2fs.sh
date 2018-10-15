#!/usr/bin/env bash

# Create an ext2 filesystem from a directory without sudo!
#
# - https://unix.stackexchange.com/questions/423965/create-a-filesystem-as-a-non-root-user
# - https://superuser.com/questions/605196/how-to-create-ext2-image-without-superuser-rights/1366762#1366762

set -eux
d=mke2fs.tmp
rm -rf "$d"
mkdir "$d"
cd "$d"

root_dir=root
img_file=img.ext2

# Create a test directory to convert to ext2.
mkdir -p "$root_dir"
echo asdf > "${root_dir}/qwer"

# Create the ext2 without sudo!
set -e
mke2fs \
  -d "$root_dir" \
  -r 1 \
  -N 0 \
  -m 5 \
  -L '' \
  -O ^64bit \
  "$img_file" \
  32M \
;

# Test the ext2 by mounting it with sudo.
mountpoint=mnt
mkdir "$mountpoint"
sudo mount "$img_file" "$mountpoint"
sudo ls -l "$mountpoint"
sudo cmp "${mountpoint}/qwer" "${root_dir}/qwer"
sudo umount "$mountpoint"

#!/usr/bin/env bash

# Create a multi ext2 partition filesystem from two directories with sfdisk
# and mke2fs without sudo! Tested on Ubuntu 18.04.

set -eux
d=mke2fs-multi.tmp
rm -rf "$d"
mkdir "$d"
cd "$d"

root_dir_1=root1
root_dir_2=root2
partition_file_1=part1.ext2
partition_file_2=part2.ext2
img_file=img.img

# Create a test directory to convert to ext2.
mkdir -p "$root_dir_1"
echo content-1 > "${root_dir_1}/file-1"
mkdir -p "$root_dir_2"
echo content-2 > "${root_dir_2}/file-2"

# Create the 2 raw ext2 images.
rm -f "$partition_file_1"
mke2fs \
  -d "$root_dir_1" \
  -r 1 \
  -N 0 \
  -m 5 \
  -L '' \
  -O ^64bit \
  "$partition_file_1" \
  32M \
;
rm -f "$partition_file_2"
mke2fs \
  -d "$root_dir_2" \
  -r 1 \
  -N 0 \
  -m 5 \
  -L '' \
  -O ^64bit \
  "$partition_file_2" \
  32M \
;

# Default offset according to
part_table_offset=$((2**20))
partition_size_1="$(wc -c < "$partition_file_1")"
partition_size_2="$(wc -c < "$partition_file_2")"
cur_offset=0
bs=1024
dd if=/dev/zero of="$img_file" bs="$bs" count=$((($part_table_offset + $partition_size_1 + $partition_size_2)/$bs)) skip="$(($cur_offset/$bs))"
printf "
type=83, size=$(($partition_size_1/512))
type=83, size=$(($partition_size_2/512))
" | sfdisk "$img_file"
cur_offset=$(($cur_offset + $part_table_offset))
dd if="$partition_file_1" of="$img_file" bs="$bs" seek="$(($cur_offset/$bs))"
cur_offset=$(($cur_offset + $partition_size_1))
dd if="$partition_file_2" of="$img_file" bs="$bs" seek="$(($cur_offset/$bs))"
cur_offset=$(($cur_offset + $partition_size_2))
rm "$partition_file_1" "$partition_file_2"

# Test the ext2 by mounting it with sudo.
# sudo is only used for testing, the image is completely ready at this point.

# losetup automation functions from:
# https://stackoverflow.com/questions/1419489/how-to-mount-one-partition-from-an-image-file-that-contains-multiple-partitions/39675265#39675265
los() (
  img="$1"
  dev="$(sudo losetup --show -f -P "$img")"
  echo "$dev"
  for part in "$dev"?*; do
    if [ "$part" = "${dev}p*" ]; then
      part="${dev}"
    fi
    dst="/mnt/$(basename "$part")"
    echo "$dst"
    sudo mkdir -p "$dst"
    sudo mount "$part" "$dst"
  done
)
losd() (
  dev="/dev/loop$1"
  for part in "$dev"?*; do
    if [ "$part" = "${dev}p*" ]; then
      part="${dev}"
    fi
    dst="/mnt/$(basename "$part")"
    sudo umount "$dst"
  done
  sudo losetup -d "$dev"
)

loop_id="$(los "$img_file")"
loop_id="$(printf "$loop_id" | head -n1 | tail -c 2)"
sudo cmp /mnt/loop0p1/file-1 "${root_dir_1}/file-1"
sudo cmp /mnt/loop0p2/file-2 "${root_dir_2}/file-2"
losd "$loop_id"

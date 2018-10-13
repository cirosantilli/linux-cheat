#!/usr/bin/env bash
set -eux

# https://askubuntu.com/questions/109413/how-do-i-use-overlayfs/1075564#1075564
# https://askubuntu.com/questions/699565/example-overlayfs-usage

# Global setup.
top=overlayfs.tmp
rm -rf "$top"
mkdir -p "$top"
cd "$top"

# Create the filesystems.
dd if=/dev/zero of=lower.ext4 bs=1024 count=102400
mkfs -t ext4 lower.ext4
cp lower.ext4 upper.ext4
mkdir lower upper overlay
sudo mount lower.ext4 lower
sudo mount upper.ext4 upper
sudo chown "$USER:$USER" lower upper
printf lower-content > lower/lower-file
# Upper and work must be on the same filesystem.
mkdir upper/upper upper/work
printf upper-content > upper/upper/upper-file
# Work must be empty. E.g. this would be bad.
#echo 'work-content' > upper/work/work-file
# Make the lower readonly to show that that is possible:
# writes actually end up on the upper filesystem.
sudo mount -o remount,ro lower.ext4 lower

# Create the overlay mount.
sudo mount \
  -t overlay \
  -o lowerdir=lower,upperdir=upper/upper,workdir=upper/work \
  none \
  overlay \
;

# Interact with the mount.
printf 'overlay-content' > overlay/overlay-file
ls lower upper/upper upper/work overlay

# Unmount the overlay and observe state.
sudo umount overlay
ls lower upper/upper upper/work

# Cleanup.
sudo umount upper lower

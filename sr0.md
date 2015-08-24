# /dev/sr0

# sr0

# /dev/sdc

# sdc

# /dev/cdrom

# cdrom

CD, DVD, blue ray, etc.

Type, major, minor: block, 11, one per disk drive.

TODO why not one per partition like `/dev/sda1`, `/dev/sda2`, etc.? What is the physical difference?

TODO: vs `/dev/sda`, major 8? `Documentation/devices.txt` says that both are SCSI devices.

`/dev/cdrom` is a symlink `sr0`.

`/dev/sdcX` is the new name for `srX` as of kernel 4.1, `sr` was deprecated.

TODO why does it exist even if there is no CD inserted? Trying to mount it gives:

    mount: no medium found on /dev/sr0

is this an specific system call error?

# Sparse files

Requires filesystem and kernel support. Supported on Windows NTFS and Unixes, but not Apple's HFS+.

Create:

    truncate -s 512M file.img

Observe sparse size:

    $ du -h --apparent-size file.img
    512M    file.img

Observe actual size:

    $ du -h file.img
    0       file.img

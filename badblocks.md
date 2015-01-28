# badblocks

e2fsprogs package.

Most useful invocation:

	badblocks -nvs /dev/sdb

- `-n`: non-destructive read-write mode. The default is non-destructive read-only.
- `-s`: show progress
- `-v`: verbose information

The output of `badblocks -v` can be used as the input of `e2fsck -l` to mark some blocks as bad and not use them.

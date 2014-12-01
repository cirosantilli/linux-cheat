# du

POSIX 7 <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/du.html>

Mnemonic: Disk Usage.

Get disk usage per file/dir:

    du -hs * | sort -hr

- `-h`: human readable: GiB, MiB, B
- `-s`: summarize: only for directories in `*,` not subdirectories

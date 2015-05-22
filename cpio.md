# cpio

GNU: <http://www.gnu.org/software/cpio/manual/cpio.html>. Ubuntu `cpio` package.

Was POSIX.1-1988, but it was omitted from POSIX.1-2001. The POSIX 2008 `pax` utility [defines](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html#tag_20_92_13_07) and implements the `cpio` format however. The file format is very simple.

Copy files between archives. Also the name of a specialized archive format of the program.

Generate a `.cpio` archive containing files `a` and `b`:

    printf '0' > /tmp/a
    printf '1' > /tmp/b
    printf '/tmp/a\n/tmp/b\n' | cpio -o > /tmp/ab.cpio
    hd /tmp/ab.cpio

Find selected files and add them to the archive, building and keeping their relative directory structure:

    find . -type f | cpio -pvdumB /tmp/find.cpio

Decompress `cpio` archive:

    cpio -i <ab.cpio

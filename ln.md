# ln

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/ln.html>

Make hardlinks and symlinks

This can also be done with `cp`

Hardlink:

    ln <dest> [<name>]

If name is not given, use same basename as `dest` and create on current directory:

    ln ../Makefile

Symlink files only:

    ln -s dest name

Symlink dir:

    ln -ds dest name

The link will be created even if the destination does not exist:

    ln -s idontexist name

If the name is in another dir, the destination is not changed by default:

    mkdir d
    ln -s a d/a
    [ `readlink d/a` = a ] || exit 1

To create relative to `dest`, use `-r`:

    mkdir d
    ln -rs a d/a
    [ `readlink d/a` = ../a ] || exit 1

If the name is in another dir, the destination is not changed by default:

Absolute link:

    ln /full/path/to/dest name
    [ `readlink name` = "/full/path/to/dest" ] || exit 1

## Trailing slash in link location

The following fails:

    ln -s a b/

It seems that POSIX says that `b/` is the same as `b/.`, which must be a directory.

So in scripts that might take `b/` (e.g. an input that comes from auto-completion), you have to do `${location%/}`.

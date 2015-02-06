# stat

Coreutils.

Unfortunately, not in POSIX, which only provides the C API <http://pubs.opengroup.org/onlinepubs/009695399/functions/stat.html>

CLI for sys_stat.

Get file/dir info such as:

- size
- owner
- group
- permissions
- last access date
- create date
- modify date

Example:

      touch f
      stat f

## c

Format string:

    chmod 1234 f
    [ `stat -c "%a" f` = "234" ] || exit 1

    chmod a=rt f
    [ "`stat -c "%A" f`" = "-r--r--r-T" ] || exit 1

Inode:

    touch a
    ln a b
    [ "`stat -c "%i" a`" = "`stat -c '%i' b`" ] || exit 1

## print

Like `-c` but interprets escapes like `\n`:

    touch a
    echo "`stat --print "%a\n%a\n" a`"
    [ "`stat --print "\n" a`" = $'\n' ] || exit 1

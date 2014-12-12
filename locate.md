# locate

Searches for files in entire computer.

Prints all matches.

This uses a database, which must be updated with `updatedb` before your new file is found.

Commonly, `updatedb` is a cronjob.

Match any substring in entire path:

    locate a
    locate /a

To force update of file cache, use `updatedb`.

## updatedb

Update file cache for locate:

    sudo updatedb

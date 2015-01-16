# file

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/file.html>

Attempts to determine file type and retrieve metadata.

This is in general impossible, but program makes good guesses.

    echo a > a
    file a

Output:

    a: ASCII text

As you can see it is a good quick and dirty way to determine file encoding: <http://superuser.com/questions/301552/how-to-auto-detect-text-file-encoding>

## L

Follow links:

    $ echo a > a
    $ ln -s a b
    $ file b
    b: symbolic link to `a'
    $ file -L b
    b: ASCII text

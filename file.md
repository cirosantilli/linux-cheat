#file

POSIX 7

Attempts to determine file type and retrieve metadata.

This is in general impossible,
but program makes good guesses.

    echo a > a
    file a

Output:

    a: ASCII text

##L

Follow links:

    $ echo a > a
    $ ln -s a b
    $ file b
    b: symbolic link to `a'
    $ file -L b
    b: ASCII text

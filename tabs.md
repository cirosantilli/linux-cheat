# tabs

POSIX 7 <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/tabs.html>

Set the tab size displayed by the terminal.

The default is 8.

E.g.:

    printf '1\t1\n12345678\n'

shows on the terminal as:

    1       1
    12345678

If you do:

    tabs 4

then we see instead:

    1   1
    12345678

Tabs go up to multiples, so:

    printf '1\t1\n12\t1\n12345678\n'

Shows as:

    1       1
    12      1
    12345678

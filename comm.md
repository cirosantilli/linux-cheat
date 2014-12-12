# comm

Ordered list diff.

POSIX 7. <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/comm.html>

Coreutils package.

    cd "`mktemp -d`"
    echo -e "a\nc" > a
    echo -e "b\nc" > b
    comm a b

Output:

    a
    \tb
    \t\tc

This produces 3 columns by indentation:

- lines only in `a`
- lines only in `b`
- lines in both

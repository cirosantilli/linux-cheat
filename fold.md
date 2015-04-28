# fold

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/fold.html>

Wrap lines:

    [ "$(printf "aaaa\nbb" | fold -w 3)" = "$(printf 'aaa\na\nbb\n')" ] || exit 1

`-s`: only break at spaces:

    [ "$(printf "12345 6\n" | fold -s -w 3)" = "$(printf '123\n45 \n6\n')" ] || exit 1

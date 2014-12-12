# head

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/head.html>

Keep only 10 first lines:

    seq 20 | head

Keep only 2 first lines:

    [ "$(printf '1\n2\n3\n4\n' | head -n2)" = "$(printf '1\n2\n')" ] || exit 1

2 first bytes:

    [ "$(echo -en 'abc' | head -c 2)" = 'ab' ] || exit 1

## GNU extensions

Remove last two bytes:

    [ "$(echo -en 'abc' | head -c -2)" = 'a' ] || exit 1

# tail

POSIX 7 <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/tail.html>

Opposite of head.

Keep only 2 last lines:

    [ "$(printf '1\n2\n3\n4\n5\n' | tail -n2)" = "$(printf '4\n5\n')" ] || exit 1

Same with negative sign:

    [ "$(printf '1\n2\n3\n4\n5\n' | tail -n-2)" = "$(printf '4\n5\n')" ] || exit 1

Same without the `-n`:

    [ "$(printf '1\n2\n3\n4\n5\n' | tail -2)" = "$(printf '4\n5\n')" ] || exit 1

Keep all lines starting from the second:

    [ "$(printf '1\n2\n3\n4\n5\n' | tail -n+2)" = "$(printf '2\n3\n4\n5\n')" ] || exit 1

Operate on bytes instead of lines:

    [ "$(printf '12345' | tail -c2)" = "$(printf '45')" ] || exit 1

## GNU Coreutils extensions

Keep only lines from the Nth onwards:

    [ "$(printf "1\n2\n3\n4\n" | tail -n +2)" = "$(printf "2\n3\n4\n")" ] || exit 1
    [ "$(printf "1\n2\n3\n4\n" | tail -n +3)" = "$(printf "3\n4\n")" ] || exit 1

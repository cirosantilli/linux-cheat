# tail

POSIX 7:

Opposite of head.

Show last 10 lines:

    seq 20 | tail

Keep only 2 last lines:

    [ "$(printf "1\n2\n3\n4\n" | tail -n2)" = "$(printf "3\n4\n")" ] || exit 1

## GNU Coreutils extensions

Keep only lines from the Nth onwards:

    [ "$(printf "1\n2\n3\n4\n" | tail -n +2)" = "$(printf "2\n3\n4\n")" ] || exit 1
    [ "$(printf "1\n2\n3\n4\n" | tail -n +3)" = "$(printf "3\n4\n")" ] || exit 1

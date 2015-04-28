# uniq

POSIX: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/uniq.html>

*Ajacent* dupe line operations.

Remove adjacent dupes lines:

    [ "$(printf 'a\nb\n' | uniq )" = "$(printf "a\nb")" ] || exit 1
    [ "$(printf 'a\na\n' | uniq )" = 'a' ] || exit 1

Non-adjacent dupes are not removed:

    [ "$(printf 'a\nb\na\na\n' | uniq )" = "$( printf "a\nb\na")" ] || exit 1

Thus the sort combo:

    [ "$(printf 'a\nb\na\na\n' | sort | uniq )" = "$(printf "a\nb")" ] || exit 1

Other options:

- `-u`: only show lines that have no dupe
- `-d`: dupe lines only
- `-c`: shows dupe count before each line

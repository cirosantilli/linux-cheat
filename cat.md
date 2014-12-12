## cat

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cat.html>

Concatenate files to stdout.

```sh
echo asdf > a
echo qwer > b

[ "$(cat a)" = 'asdf' ] || exit 1
[ "$(cat b)" = 'qwer' ] || exit 1

[ "$(cat a b)" = "$(printf 'asdf\nqwer'") ] || exit 1
```

Stdin:

```sh
[ "$(echo a | cat)" = 'a' ] || exit 1
```

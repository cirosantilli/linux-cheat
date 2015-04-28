# seq

Coreutils: <https://www.gnu.org/software/coreutils/manual/html_node/seq-invocation.html>

Print range to stdout:

    [ "$(seq 3)" = "$(printf '1\n2\n3\n')" ] || exit 1
    [ "$(seq 2 4)" = "$(printf '2\n3\n4\n')" ] || exit 1
    [ "$(seq 1 2 7)" = "$(printf '1\n3\n5\n7\n')" ] || exit 1

Options:

- `s`: separator. Default: `' '`

## Usage in loops

`seq` is a good possibility for loops:

    seq 3 | while read i; do
        echo "$i"
    done

## Alternatives

Bash brace expansion:

    for i in {1..10}; do echo $i; done

but this is less efficient for longer ranges as it will expand huge command on the command line.

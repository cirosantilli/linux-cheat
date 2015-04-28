# shuf

Coreutils: <https://www.gnu.org/software/coreutils/manual/html_node/shuf-invocation.html>

Generate a random permutation of the input lines:

    printf 'a\nb\nc\nd\n' | shuf

Possible output:

    d
    a
    c
    b

## i

Generate a random permutation of the range `{1..4}`:

    shuf -i1-4

Special case: generate one random integer in range:

    shuf -i1-4 -n1

## Alternatives

Depending on the use case:

- Bash built-in `RANDOM`
- `/dev/random`

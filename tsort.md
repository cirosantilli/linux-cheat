# tsort

POSIX: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/tsort.html>

Coreutils: <https://www.gnu.org/software/coreutils/manual/html_node/tsort-invocation.html>

Topological sorting: <http://en.wikipedia.org/wiki/Tsort_%28Unix%29>

This exists because the operation is used during the linking step.

Consider the following diamond graph:

    (1)
     |
     +---+
     |   |
     v   v
    (2) (3)
     |   |
     +---+
     |
     v
    (4)

It can be represented as:

    1 2
    1 3
    2 4
    3 4

And then:

    output="$(printf '1 2\n1 3\n2 4\n3 4\n' | tsort)"
    [ "$output" = "$(printf '1\n2\n3\n4\n')" ] || \
    [ "$output" = "$(printf '1\n3\n2\n4\n')" ] || \
    exit 1

If there is a cycle in the graph, then it cannot be sorted, and we get:

    printf '1 2\n2 1\n' | tsort && exit 1

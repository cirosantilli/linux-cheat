# tee

POSIX 7

Echo stdin to multiple files ant to stdout.

To stdout and file:

    echo a | tee file

To file and stderr:

    echo a | tee file 1>&2

Append to file:

    echo a | tee –a file

To multiple files:

    echo a | tee f1 f2 f3

To multiple processes:

    echo a | tee >(seqn 2) tee >(seqn 2) | tr a b

Process are run in parallel so the output order is variable.

Tee to pipe and stdout at the same time:

    echo a | tee /dev/tty | grep b

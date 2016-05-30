# parallel

GNU.

## Basic usage

Run `echo` 100 times in parallel:

    seq 100 | parallel echo '{}'

## halt

Determines what happens on failure:

    seq 100 | parallel --halt=0 false
    echo $?

- `0`: default. Don't halt on failure. Exit status is the number of failures.
- `1`: don't start new processes on failure. Exit status is the last failure.
- `2`: kill everyone else on failure.

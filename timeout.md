# timeout

Coreutils.

Run command for at most `n` seconds, and kill it if it does not finish in time:

    [ "$(timeout 3 bash -c 'for i in {1..2}; do echo $i; sleep 1; done')" = "$(printf '1\n2\n')" ] || exit 1
    [ "$(timeout 1 bash -c 'for i in {1..2}; do echo $i; sleep 1; done')" = '1' ] || exit 1

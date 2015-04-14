# PRECIOUS

POSIX 7.

Special target.

Keeps given intermediate build files.

Test:

    make a.tmp

With precious: both `a.tmp` and `a.tmp2` are created.

Without: `a.tmp2` is created but gets removed afterwards. You can observe this with `make --dry-run a.tmp` which shows:

    touch a.tmp2
    touch a.tmp
    rm b.tmp2

TODO understand better with more examples.

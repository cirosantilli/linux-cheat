# tr

POSIX 7.

Character-wise replace operations.

Replace `a` by `A`, `b` by `B` and `c` by `C`:

    [ `echo -n cab | tr abc ABC` = CAB ] || exit 1

Ranges work as expected. Convert to uppercase:

    [ `echo -n cab | tr a-z A-Z` = CAB ] || exit 1

POSIX character classes are understood. Remove non-alphanumeric characters:

    [ `echo -n 'ab_@' | tr -cd "[:alpha:]"` = ab ] || exit 1

-   `-c`: complement and replace. Replace all non `abc` chars by `d`:

        [ `echo -n dcba | tr -c abc 0` = 0cba ] || exit 1

-   `-d`: delete `abc` characters:

        [ `echo -n dcba | tr -d abc` = d ] || exit 1

-   `s`: replace multiple consecutive `a` and `b` by a single character:

        [ `echo -n aabbaac | tr -s ab` = abac ] || exit 1

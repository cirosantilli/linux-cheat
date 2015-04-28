# sort

POSIX: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sort.html>

Sort line wise.

Uses External R-Way merge. This algorithm allows to sort files that are larger than RAM memory.

Sort `f1`, `f2` together line wise:

    sort f1 f2

Useful options:

-   `-r`: reverse order

-   `-n`: numbers

-   `-u`: `uniq`

-   `-t:`: set field separator to `:`

-   `-k5`: sort by the Nth field.

    Example:

        sort -k 2,2n -k 4,4hr

    - sort field `2` (from `2` to `2`) numerically
    - sort field `4` by human sizes and reverse

    From field 2 to 2, numerically, then from 4 to 4, human and reverse

-   `-R`: randomize: pseudo reverse of sorting.

-   `-h`: sort by human readable file sizes like `1k`, `2M`, `3G`

-   `-f`: ignore case

-   `-fs`: ignore case and put always upper before lower

-   `-b`: ignore leading blanks

-   `-uf`: remove duplicates case insensitive

-   `-m`: suppose `f1` and `f2` are already sorted, making sort faster

-   `-c`: check if is sorted

## Custom line separator

<http://stackoverflow.com/questions/2625976/sorting-space-delimited-numbers-with-linux-bash>

No direct way apparently, just `tr` it.

## GNU extensions

-   `-V`: sort dot separated versions numbers:

        [ "$(printf '10.0\n9.10\n9.9\n' | sort -V)" = "$(printf '9.9\n9.10\n10.0\n')" ] || exit 1

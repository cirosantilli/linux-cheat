# diff

POSIX 7 <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html>, implemented on most Linux on the GNU <https://www.gnu.org/software/diffutils/> package.

<http://en.wikipedia.org/wiki/Diff_utility>

Compare the contents of two files and show only where they differ. Can also operate recursively in directories with `-r`.

Mathematically, each unique line is treated as a different input token, and then (TODO confirm) it computes the <http://en.wikipedia.org/wiki/Levenshtein_distance> between the two strings.

Equal:

    diff <(printf '0\n1\n2\n') <(printf '0\n1\n2\n')

Output: none.

Deletion of one line:

    diff <(printf '0\n1\n2\n') <(printf '0\n2\n')

Output:

    2d1
    < 1

Deletion of one line further down:

    diff <(printf '0\n1\n2\n3\n') <(printf '0\n1\n3\n')

Output:

    3d2
    < 2

Deletion of two lines:

    diff <(printf '0\n1\n2\n3\n') <(printf '0\n3\n')

Output:

    2,3d1
    < 1
    < 2

Two deletions:

    diff <(printf '0\n1\n2\n3\n4\n5\n6\n') <(printf '0\n2\n3\n4\n6\n')

Output:

    2d1
    < 1
    6d4
    < 5

Two double deletions:

    diff <(printf '0\n1\n2\n3\n4\n5\n6\n') <(printf '0\n3\n6\n')

Output:

    2,3d1
    < 1
    < 2
    5,6d2
    < 4
    < 5

Addition of one line:

    diff  <(printf '0\n2\n') <(printf '0\n1\n2\n')

Output:

    1a2
    > 1

Addition of two lines:

    diff <(printf '0\n3\n') <(printf '0\n1\n2\n3\n')

Output:

    1a2,3
    > 1
    > 2

Change one line:

    diff <(printf '0\n1\n2\n') <(printf '0\na\n2\n')

Output:

    2c2
    < 1
    ---
    > a

Change two lines:

    diff <(printf '0\n1\n2\n3\n') <(printf '0\na\nb\n3\n')

Output:

    2,3c2,3
    < 1
    < 2
    ---
    > a
    > b

## u

## Unified diff

Looks like Git's diff (unified format):

    diff -u <(printf '0\n1\n2\n') <(printf '0\n2\n')

Output:

    --- /dev/fd/63	2015-04-05 00:28:34.975628915 +0200
    +++ /dev/fd/62	2015-04-05 00:28:34.979628915 +0200
    @@ -1,3 +1,2 @@
    0
    -1
    2

## r

Operate in directories:

    mkdir a
    touch a/a
    touch a/c
    mkdir b
    touch b/b
    touch b/c
    diff a b

## Color output

No simple way: <http://stackoverflow.com/questions/8800578/colorize-diff-on-the-command-line>

Use `git diff`.

Unfortunately `git diff` cannot deal with pipe inputs:

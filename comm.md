# comm

Ordered list diff.

POSIX 7. <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/comm.html>

Coreutils package.

    comm <(printf 'a\nc\n') <(printf 'b\nc\n')

Output:

    a
    \tb
    \t\tc

This produces 3 columns by indentation:

- lines only in the first file
- lines only in the second file
- lines in both files

## 1

## 2

## 3

Suppress the given column.

List intersection:

    comm -12 <(printf 'a\nc\n') <(printf 'b\nc\n')

Output:

    c

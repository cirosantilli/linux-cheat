#!/usr/bin/env sh

## cut

  # POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cut.html#tag_20_28>

  # Select columns from text tables.

  # The delimiter can only be a single character, so quite limited.

  # For more complex operation such as selecting a line from a certain field, consider `awk`.

  # `-f`: field. what column to print:

    [ "$(printf 'a\tb\nc\td\n' | cut -f1)" = "$(printf 'a\nc')" ] || exit 1

  # `-d`: set delimiter:

    [ "$(printf 'a:b\nc:d\n' | cut -d: -f1)" = "$(printf 'a\nc')" ] || exit 1

  # Gets last if column is after the last:

    [ "$(printf 'a\n' | cut -d: -f2)" = 'a' ] || exit 1

  # Multiple columns, first and third:

    [ "$(printf 'a:b:c\nd:e:f\n' | cut -d: -f1,3)" = "$(printf 'a:c\nd:f')" ] || exit 1

  # Column range from second to last:

    [ "$(printf 'a:b:c\nd:e:f\n' | cut -d: -f2-)" = "$(printf 'b:c\ne:f')" ] || exit 1

  # Empty field (two adjacent delimiters):

    [ "$(printf 'a::c\nd:e:f\n' | cut -d: -f2)" = "$(printf '\ne')" ] || exit 1

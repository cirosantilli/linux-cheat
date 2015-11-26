#!/usr/bin/env bash

# POSIX 7. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html

# Turing complet, but use only for *ultra simple* POSIX text table field manipulation,
# e.g.: if a column equals X, print Y.

# it only has better golfing on that very limited problem set.

# For more sanity, use Python.

## Basic examples

  # Example of where you should use it: print second column is the first is `'a'`:

    printf 'a 1\nb 2\na 3' | awk '$1 == "a" { print $2 }'

  # Numeric comparison: print col 2 if col 1 equals 1:

    printf '01 a\n2 b\n001 c' | awk '$1 == 1 { print $2 }'

  # Simple arithmetic operations:

    printf 'a 01\nb 2\na 3' | awk '$2 == 1 { print $1 }'

  # Line number operations: print every nth line:

    seq 10 | awk 'NR % 3 == 0'

  # Line number operations: delete every nth line:

    seq 10 | awk 'NR % 3 != 0'

  # GNU sed can do those with the `~` extension:
  # http://superuser.com/questions/396536/how-to-keep-only-every-nth-line-of-a-file

## General syntax

  # Similar to sed.

  # A general awk program is of the type:

    # BEGIN       { STATEMENT_BEGIN }
    # CONDITION0  { STATEMENT0   }
    # CONDITION1  { STATEMENT1   }
    # ...
    # CONDITION_N { STATEMENT_N   }
    # END         { STATEMENT_END  }

  # To put multiple statements on a single lime, use `;`.

  printf '1 2\n3 4' | awk 'BEGIN{print "b"}1<2{print "l"}1<2{print "l2"; print "l3"}1>2{print "l4"}END{print "e"}'
  #$'b\nl\nl2\nl3\nl\nl2\nl3\ne

  echo '0.5 0.5' | awk '{print $1 + $2}'
  #1

  # If a statment is missing, print is implied:

    [ "$(echo 'a' | awk '1')" = 'a' ] || exit 1

  # If a condition is missing, 1 (true) is implied:

    [ "$(echo 'a' | awk '{print}')" = 'a' ] || exit 1

  # - arithmetic: same as C: +, *, -, /
  # - string comp: `==` and `!=`
  # - posix string ERE regex comp: ~// !~// (sub match accepted unless you use `^$`)
  # - if else for while: like C

## Variables

  # Same as c

  # Initialized to 0.

  # $0: entire record
  # $\n: fields
  # last field: $(NF-1)

  ## FS

    # Field (column) separator.

    # FS=':' FS=/[[:space:]]/ -F'/[[:space:]]/'

  ## OFS: output field separator

  ## RS: record (line) separator

  ## ORS: output ""

  ## NF: number of fields

  ## NR: number of current record

  ## FNR: total number of records in current file file

  ## length: number of bytes of the line, excluding the newline

  ## RS

    # Record separator.

    # `''` is a special value that selects blank lines, i.e. paragraphs:

    # - http://unix.stackexchange.com/questions/136218/grep-sed-or-awk-print-entire-paragraph-in-a-file-on-pattern-match
    # - http://unix.stackexchange.com/questions/82944/how-to-grep-for-text-in-a-file-and-display-the-paragraph-that-has-the-text/82958#82958

      [ "$(printf '1 a0\na1\na2\n\nb0\nb1\nb2\n\nc0\nc1\nc2\n' | awk -v RS='' '/b1/')" = "$(printf 'b0\nb1\nb2')" ] || exit 1

## String to int

    awk 'BEGIN {print "1"+1}'
    awk 'BEGIN {print " 1"+1}'
    #2

## print

  # By default, print does space separation:

    awk 'BEGIN {print "a", 1}'
    #'a 1'

  # String concat:

    awk 'BEGIN {print "a" "b"}'
    #'ab'

  # Without arguments, it defaults to `print $0`:

    [ "$(echo 'a' | awk '{print}')" = 'a' ] || exit 1

  # Note that the default action is to print:

    [ "$(echo 'a' | awk '1')" = 'a' ] || exit 1
    [ "$(echo 'a' | awk '1;1')" = "$(printf "a\na")" ] || exit 1

## next

  # Stop current action, move to next line.

## Subtract adjacent lines

  # TODO fails if the first is zero.

    #[ "$(printf '0\n1\n3\n6' | awk awk 'p{print $0-p}{p=$0}')" = "$(printf '1\n2\n3')" ] || exit 1

## Applications

  # Print second field of all entries if first field equals a given integer value:

    [ "$(printf '1 a\n2 b\n01 c\n' | awk '$1 == 1 { print $2 }')" = "$(printf 'a\nc')" ] || exit 1

  # Same as above, but match strings (note how `01` equals `1` for integer comparison;

    [ "$(printf '1 a\n2 b\n01 c\n' | awk '$1 == "1" { print $2 }')" = "$(printf 'a')" ] || exit 1

  # Same as above, but print only first match:

    [ "$(printf '1 a\n2 b\n1 c\n' | awk '$1 == 1 { print $2; exit }')" = 'a' ] || exit 1

  # Same as above, but match EREs:

    [ "$(printf '1 a\n2 b\n1 c\n' | awk '$1 ~/^1$/ { print $2; exit }')" = 'a' ] || exit 1

  # Sum column:

    #awk '{sum += $1} END {print sum}'

  # Variables start as 0, so no need to initalize them.
  # http://unix.stackexchange.com/questions/115998/how-do-i-multiply-and-sum-column-data-using-awk-and-or-sed

  # Skip blank lines:
  # http://stackoverflow.com/questions/11687216/awk-to-skip-the-blank-lines

echo 'ALL ASSERTS PASSED'

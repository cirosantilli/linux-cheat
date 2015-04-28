#!/usr/bin/env bash

# POSIX 7. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html

# Turing Machine, but use only for *ultra simple* POSIX text table field manipulation:
# it only has better golfing on that very limited problem set.

# For more sanity, use Perl or Python.

## variables

  #same as c

  #initialized to 0.

  #$0: entire record
  #$\n: fields
  #last field: $(NF-1)

  ## FS
    #field (column) separator
    #FS=':' FS=/[[:space:]]/ -F'/[[:space:]]/'
  #OFS: output field separator
  #RS: record (line) separator
  #ORS: output ""
  #NF: number of fields
  #NR: number of current record
  #FNR: total number of records in cur file

#- arithmetic: same as C: +, *, -, /

#- string comp: `==` and `!=`

#- posix string ERE regex comp: ~// !~// (sub match accepted unless you use `^$`)

#- if else for while: like C

## general syntax

  #A general awk program is of the type:

    #BEGIN     { STATEMENT_BEGIN }
    #CONDITION0   { STATEMENT0   }
    #CONDITION1   { STATEMENT1   }
    #...
    #CONDITION_N  { STATEMENT_N   }
    #END      { STATEMENT_END  }

  printf '1 2\n3 4' | awk 'BEGIN{print "b"}1<2{print "l"}1<2{print "l2"; print "l3"}1>2{print "l4"}END{print "e"}'
  #$'b\nl\nl2\nl3\nl\nl2\nl3\ne

  echo '0.5 0.5' | awk '{print $1+$2}'
  #1

## string num conversion

    awk 'BEGIN{print "1"+1}'
    awk 'BEGIN{print " 1"+1}'
    #2

## print

  awk 'BEGIN{print "a", 1}'
    #'a 1'
      #by default, print does space separation
  awk 'BEGIN{print "a" "b"}'
    #'ab'
      #string concat

    [ "$(echo 'a' | awk '{print}')" = 'a' ] || exit 1

## applications

  # Print second field of all entries if first field equals a given integer value:

    [ "$(printf '1 a\n2 b\n01 c\n' | awk '$1 == 1 { print $2 }')" = "$(printf 'a\nc')" ] || exit 1

  # Same as above, but match strings (note how `01` equals `1` for integer comparison;

    [ "$(printf '1 a\n2 b\n01 c\n' | awk '$1 == "1" { print $2 }')" = "$(printf 'a')" ] || exit 1

  # Same as above, but print only first match:

    [ "$(printf '1 a\n2 b\n1 c\n' | awk '$1 == 1 { print $2; exit }')" = 'a' ] || exit 1

  # Same as above, but match EREs:

    [ "$(printf '1 a\n2 b\n1 c\n' | awk '$1 ~/^1$/ { print $2; exit }')" = 'a' ] || exit 1

## RS

  # Record separator.

  # `''` is a special value that selects blank lines, i.e. paragraphs:
  # http://unix.stackexchange.com/questions/82944/how-to-grep-for-text-in-a-file-and-display-the-paragraph-that-has-the-text/82958#82958

    [ "$(printf '1 a0\na1\na2\n\nb0\nb1\nb2\n\nc0\nc1\nc2\n' | awk -v RS='' '/b1/')" = "$(printf 'b0\nb1\nb2')" ] || exit 1

## Subtract adjacent lines

  # TODO fails if the first is zero.

    #[ "$(printf '0\n1\n3\n6' | awk awk 'p{print $0-p}{p=$0}')" = "$(printf '1\n2\n3')" ] || exit 1

echo 'ALL ASSERTS PASSED'

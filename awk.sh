#!/usr/bin/env bash

# POSIX 7.

# Turing Machine, but use only for **ultra simple** POSIX text table field manipulation.

# awk only gets slightly better golfing on a very limited problem set

# The only real advantage of awk over perl is the fact that it is in POSIX,
# while Perl is only in LSB. awk only has slighty better golfing.
# Therefore: don't rely on awk GNU extensions, or you lose the only major advantage of awk!

# For even more sanity, use Python.

##variables

  #same as c

  #initialized to 0.

  #$0: entire record
  #$\n: fields
  #last field: $(NF-1)

  ##FS
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

##general syntax

  #A general awk program is of the type:

    #BEGIN     { STATEMENT_BEGIN }
    #CONDITION0   { STATEMENT0   }
    #CONDITION1   { STATEMENT1   }
    #...
    #CONDITION_N  { STATEMENT_N   }
    #END      { STATEMENT_END  }

  echo $'1 2\n3 4' | awk 'BEGIN{print "b"}1<2{print "l"}1<2{print "l2"; print "l3"}1>2{print "l4"}END{print "e"}'
  #$'b\nl\nl2\nl3\nl\nl2\nl3\ne

  echo '0.5 0.5' | awk '{print $1+$2}'
  #1

##string num conversion

    awk 'BEGIN{print "1"+1}'
    awk 'BEGIN{print " 1"+1}'
    #2

##print

  awk 'BEGIN{print "a", 1}'
    #'a 1'
      #by default, print does space separation
  awk 'BEGIN{print "a"."b"}'
    #'ab'
      #string concat
  awk '{print}'
    #cat

##applications

  #Print second field of all entries if first field equals:

    [ "$(echo $'1 a\n2 b\n1 c' | awk '$1 == 1 { print $2 }')" = "$(printf 'a\nc')" ] || exit 1

  #Same as above, but print only first match:

    [ "$(echo $'1 a\n2 b\n1 c' | awk '$1 == 1 { print $2; exit }')" = a ] || exit 1

  #Same as above, but match EREs:

    [ "$(echo $'1 a\n2 b\n1 c' | awk '$1 ~/^1$/ { print $2; exit }')" = a ] || exit 1

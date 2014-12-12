# POSIX 7.

# Exec string in current bash

  eval "a=b"
  [ $a = b ] || exit 1

# Concatenates arguments, space separated:

  [ `eval echo a` = a ] || exit 1

## applications

  # Make varname from var>

    a=b
    eval "$a=c"
    [ $b = c ] || exit 1


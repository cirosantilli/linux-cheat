# POSIX 7

# Show all environment variables and their values:

  #env

# Sample output:

  #A=b c
  #B=de

# Change environment for a single command:

  a='b'
  [ "$(env a='c' bash -c 'echo "$a"')" = 'c' ] || exit 1
  [ "$a" = 'b' ] || exit 1

# In bash it is also possible to omit `env` TODO POSIX?:

  a='b'
  [ "$(a='c' bash -c 'echo "$a"')" = 'c' ] || exit 1
  [ "$a" = 'b' ] || exit 1

## i

  # Run command in a clean environment without inheriting exports
  # except those explicitly given.

    export a='b'
    [ "$(env -i c='d' env)" = 'c=d' ] || exit 1

  # There are some special variables however that do get exported anyways:

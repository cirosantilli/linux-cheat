#!/usr/bin/env bash

## printf

  # POSIX 7: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/printf.html

  # Goes around echo's quicks.

  # Similar to C printf, but not identical.

  # Does not automatically append newline like `echo`:

    [ "$(printf 'a')" = 'a' ] || exit 1

  ## \

  ## Backslash escapes

    # Interprets backslash escapes much like C printf:

      printf 'Interpret\nbackslash\n'

    # \x is a notable exception: only \123 octals are specified.
    #
    # Fails in `sh`, but exists as a Bash extension.
    #
    # POSIX explicitly says:
    #
    # > Hexadecimal character constants as defined in the ISO C standard
    # are not recognized in the format operand because there is no consistent way
    # to detect the end of the constant.

  # Print strings that could be command line arguments:

    [ "$(printf '%s' '-n')" = '-n' ] || exit 1

  # Supports C format strings:

    [ "$(printf '%1.2d' 1)" = '01' ] || exit 1
    [ "$(printf '%1.2f' 1.23)"  = '1.23' ] || exit 1

  # Print a string ignoring all escape sequences:

    [ "$(printf '%s' '\n\r')" = '\n\r' ] || exit 1

  ## Extensions to POSIX printf

    ## POSIX specified

    ## b

      # Do interpret escapes sequences in a string argument:

        printf 'Interpret%bArgument\n' '\n'

    ## TODO not sure if POSIX specified

      ## q

        # Shell escape an argument:

          [ "$(printf '%q' 'a b')" = 'a\ b' ] || exit 1

      ## Arguments in bases other than 1

        # Great way to convert hex to decimal:

          [ "$(printf '%d' '0x010')" = '8' ] || exit 1
          [ "$(printf '%d' '0x10')" = '16' ] || exit 1

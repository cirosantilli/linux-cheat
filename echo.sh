## echo

  #POSIX 7.

  ## versions

    #POSIX says that: A string to be written to standard output.

      #If the first operand is -n, or if any of the operands contain a <backslash> character,
      #the results are implementation-defined.

    #Which means that is your `echo` input statrs with `-n` or contains a backslash `\`,
    #behaviour is undetermined.

    #To make things worse, in practice different implementations *do* have different standards.

    #- On Ubuntu 13.04, `sh` has an `echo` built-in.

      #This version only accepts `-n` as a command line option,
      #and backslash escapes are always interpreted.

    #- `/bin/echo` by GNU. On Ubuntu 13.04, `bash` has no built-in called `echo`,
      #and therefore uses this one.

      #In this version, you need to use the `-e` option to activate the backslash escapes.

      #It seems that this is is slighltly *not* POSIX compliant since other options are introduced
      #such as `-e`, and POSIX seems to mandate that such strings be printed (`echo -e 'a' would print `-e a`)

    #The message then is clear: if you want to use escape chars, or ommit the ending newline,
    #do *not* use `echo`. Or even better, never use echo, only `printf`.

  #print to stdout:

    [ "`echo a`" = a ] || exit 1

  #multiple arguments are space separated:

    [ "`echo a b c`" = "a b c" ] || exit 1

  ## gnu implementation

    #As explained in the versions section, POSIX does not specificy behaviour
    #if `-n` input starts or if input contains `\n`, and in practice inplementations
    #recognze other command line options besides `-n`.

    #Appends newline at end by default.

    #-n: no final newline:

      echo -n a

    #Does not interpret `\` escaped chars by default:

      [ "`echo 'a\nb'`" = $'a\\nb' ] || exit 1

    #-e: interprets \ escaped chars:

      [ "`echo -e 'a\nb'`" = $'a\nb' ] || exit 1
      [ "`echo -e '\x61'`" = $'a' ] || exit 1

    #Print the `-n` string:
    #IMPOSSIBLE! not even gnu echo supports `--` since POSIX says that this should be supported.
    #=) use `printf`.

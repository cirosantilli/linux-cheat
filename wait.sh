# POSIX 7

# Wait for process with given pid to terminate.

## $!

  # The PID of the last background process is stored in `$!`.

# Sleep 2 seconds and echo done:

  sleep 3 &
  wait $!
  echo $?

# Gets `$?` right even if process over already:

  false &
  sleep 2
  true
  wait $!
  [ "`echo $?`" = 1 ] || exit 1

  true &
  sleep 2
  false
  wait $!
  [ "`echo $?`" = 0 ] || exit 1

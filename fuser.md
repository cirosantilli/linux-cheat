#fuser

View which processes are using a device.

On Ubuntu, comes from the `psmisc` package.

Similar to `lsof`.

    exec 3<> /tmp/foo
    fuser /tmp/foo
      #/tmp/foo:            22924
    exec 3>&-
    fuser /tmp/foo
      #

Useful if you want to unmount a filesystem, and you have to find out who is still using it.

#k

Send `SIGKILL` to found process

#t

Search in given domain instead of file paths.

Possible values:

- `tcp`: TCP ports

Good combo with `k` to kill that pesky test server:

    fuser -kn tcp 3000

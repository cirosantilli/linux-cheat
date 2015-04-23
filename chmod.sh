## chmod

  # POSIX

  # Change file permissions

  # Syntax:

    # chomod [ugoa][+-=][rwxXst]+

  # Make f executable for all (owner, group and other);

    chmod a+x "$f"

  # Makes f readable for all:

    chmod a+r "$f"

  # The difference between using `a` and nothing is that when using
  # nothing `umask` comes into play.

    umask 002
    chmod +w "$f"
    stat -c "%a" "$f"
      #220
    chmod a=w "$f"
    stat -c "%a" "$f"
      #222
    chmod o=w "$f"
    stat -c "%a" "$f"
      #002

  # Make f not executable for all:

    chmod -x "$f"

  # Make file not executable and not writeble by all:

    chmod =r "$f"

  # Make f executable for owner:

    chmod u+x "$f"

  # Makes f executable for group and other:

    chmod go+x "$f"

  # Makes f readable and writible for all:

    chmod +rw "$f"

  # Same as `chmod =rwx`:

    chmod 777 "$f"

  ## sticky bit, suid sgid bits

    # Sticky bit:

      chmod 1000 "$f"
      chmod o=t "$f"
      chmod a=t "$f"
      stat -c "%A" "$f"
        #---------T
      chmod a-t "$f"
      chmod u=t "$f"
      chmod g=t "$f"
      stat -c "%A" "$f"
        #---------T
      chmod =s "$f"
      chmod 6000
        #set suid and sgid
      chmod u=s "$f"
      chmod 4000
        #set suid and sgid
      chmod g=s "$f"
      chmod 2000

    # Can't clear them on numeric mode, only symbolic:

      chmod 7777 f
      stat -c "%A" "$f"
        #-rwsrwsrws
      chmod 0 f
      stat -c "%A" "$f"
        #---S--S--T
      chmod a-st f
      stat -c "%A" "$f"
        #----------

  # Can only change permissions for files you own
  # even if you do not have all the permissions on the file:

    su a
    touch a
    chmod 777 a
    su b
    if ! chmod 770 a; then assert true; fi


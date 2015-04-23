## chown

  # POSIX 7

  # Change owner and group of files.

  # You must use sudo to do this, because otherwise users would be able to:

  # - steal ownership of files
  # - git ownership to users who do not want to own the files

    su a
    mkdir d
    touch d/f
    sudo chown newuser:newgroup d
      #must use sudo to chown
    [ `stat -c '%U' d` = newuser ] || exit 1
    [ `stat -c '%G' d` = newgroup ] || exit 1
    [ `stat -c '%U' d/f` = a ] || exit 1

  # `-R` for recursive operation:

    su a
    mkdir d
    touch d/f
    sudo chown b d
    [ `stat -c '%U' d` = newuser ] || exit 1
    [ `stat -c '%G' d` = newgroup ] || exit 1
    [ `stat -c '%U' d/f` = newuser ] || exit 1
    [ `stat -c '%G' d/f` = newgroup ] || exit 1

  # To change only user:

    sudo chown newuser

  # To change only group:

    sudo chown :newgroup


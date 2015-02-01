# POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cp.html>

# Copy files and dirs.

## Files

  # If dest does not exist, create it:

    echo a > a
    cp a b
    [ "$(cat b)" = 'a' ] || exit 1

  # If dest exists and is dir, copy into dir:

    mkdir d
    cp a d
    [ "$(cat d/a)" = 'd/a' ] || exit 1

  # If dest exists and is file, overwrite without asking!

    echo a > a
    echo b > b
    cp a b
    [ "$(cat b)" = 'a' ] || exit 1

## Directories

    function setup_test
    {
      mkdir d
      echo a > a
      echo a > d/a
      mkdir d2
      mkdir d2/d
      echo A > d2/d/a
      echo b > d2/d/b

      mkdir d3
      cd d3
      ln -s ../d2 d
      cd ..
    }

    function teardown_test
    {
      rm -r a d d2 d3
    }

  # Must use recursive `-R`, even if dir is empty

    setup_test
    if cp d e; then assert false; fi
    teardown_test

    setup_test
    cp -R d d2
    [ -d d2 ] || exit 1
    teardown_test

  # `-r` on GNU is the same as `-R`, but is a GNU extensionto POSIX 7.

  # Unlike move, can copy into dir recursively overwritting by default:

    setup_test
    cp -R d d2
    [ "`ls d2/d`"  = 'a b' ] || exit 1
    [ "`cat d2/d/a`" = 'A' ] || exit 1
    [ "`cat d2/d/b`" = 'b' ] || exit 1
    teardown_test

  # If fails however if you try to overwrite a file with a dir:

    setup_test
    if cp -R d a; then assert false; fi
    teardown_test

  # It also fails if you try to overwrite a link to a dir with a dir:

    setup_test
    if cp -R d d3; then assert false; fi
    teardown_test

## symlink

  # By default, for files copies content of symlinks to new files/dirs:

    echo a > a
    ln -s a b
    ln -s b c

    cp c d
    [ -f d ] || exit 1
    [ "$(at a)" = 'a' ] || exit 1

  # With the `-d` GNU extension, copies symlink to files into new symlinks (mnemonic: no-Dereference):

    cp -d c e
    [ -L d ] || exit 1

  # For dirs by default copies symlink into a new symlink:

    mkdir d
    ln -s d dln
    cp dln e
    [ -L e ] || exit 1

  # To dereference symlinks to directories, use `-L`:

    mkdir d
    ln -s d dln
    cp -L dln e
    [ -d e ] || exit 1

  # Does not work with `-r`. Probable rationale:
  # the only thing this could do is to copy dirs
  # and symlink files. But then why not do this with hardlinks?

## GNU extensions

  ## v

    # Be verbose and print a message saying what cp is doing.

    # Useful when copying a lot of files in an interactive session
    # to check if that progress is going on.

  ## parents

    # Generate directories in the relative path of src on top of the dst.

      mkdir 0
      mkdir 0/1
      touch 0/1/a
      mkdir 2
      cp --parents 0/1/a 2
      [ -e 2/0/1/a ] || exit 1

    # Merges existing directories:

      touch 0/1/b
      cp --parents 0/1/b 2
      [ -e 2/0/1/a ] || exit 1
      [ -e 2/0/1/b ] || exit 1

  ## l

  ## hardlink

      echo a > a
      cp -l a b
      ln -l a b
      [ "$(stat -c '%i' a)" = "$(stat -c '%i' b)" ] || exit 1

    # With `-r`, makes dirs, and hardlinks files:

      mkdir d
      touch d/a
      touch d/b
      cp -lr d e
      [ "$(stat -c '%i' d/a)" = "$(stat -c '%i' e/a)" ] || exit 1
      [ "$(stat -c '%i' d/b)" = "$(stat -c '%i' e/b)" ] || exit 1

    # If `-l` is used, does not overwrite file:

      echo a > a
      echo b > b
      if cp -l a b; then assert false; fi

    # But can overwrite if `-f` is given:

      cp -fl a b

## Applications

  # Copy all files from a directory into another existing directory (including hidden):

    cp -dR from/. to

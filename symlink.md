# Symlink

Symlink concepts and manipulation.

## Create

Use `ln -s` (POSIX 7):

    echo a > a
    ln -s a b
    [ `cat b` = a ] || exit 1

## If target is moved the link breaks

Broken links are also known as *dangling links*.

If a program tries to open them, it gets a permission error:

    echo a > a
    ln -s a b
    mv a c
    if cat b; then exit 1; fi

## Check if path is symlink

Symlinks are identified by system metadata. Programs can tell if a file is a symlink or not:

    touch a
    ln -s a b
    [ -L b ] || exit 1

## readlink

Get path to which symlink points to:

    touch a
    ln -s a b
    [ `readlink b` = a ] || exit 1

## Relative vs absolute

Symlinks can contain either relative paths or absolute paths:

    touch a
    mkdir d
    ln -s a d/a

## What programs do when they see a symlink is up to them to decide

File content changes always affect the target of the link:

    touch a
    ln -s a b
    echo a > b
    [ `cat a` = a ] || exit 1

This is the most common operation.

File operations may use the link, or the link's content, it depends on the program. For example `cp` could either copy the content or the symlink itself.

Symlinks have their own inode:

    touch a
    ln -s a b
    [ ! "`stat -c "%i" a`" = "`stat -c '%i' b`" ] || exit 1

It is therefore possible to make hardlinks of symlinks:

    touch a
    ln -s a b
    ln b c
    [ `readlink c` = a ] || exit 1

## Permissions

Symlinks always show 777 permission, but this permission means nothing:

Only the permissions and owners of target file and its subdirs matter!

Example: symlink to file

    touch f
    chmod 000 f
    ln -s f fln
    [ "$(stat -c "%A" fln)" = "lrwxrwxrwx" ] || exit 1

Still cannot `cat` from link:

    if cat fln; then assert false; fi

Trying to `chmod` the link, acts on the destination instead:

    chmod 444 f
    [ "$(stat -c "%A" f)"   = $'lr--r--r--' ] || exit 1
    [ "$(stat -c "%A" fln)" = $'lrwxrwxrwx' ] || exit 1

Example: symlink to dir:

    mkdir -m 777 d
    mkdir -m 777 d/d
    ln -ds d/d ddln
    chmod 000 d

Cannot `ls d/d` even from `ddln` because no permission on `d`:

    if ls ddln; then exit 1; fi

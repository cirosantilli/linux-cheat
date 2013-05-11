points to a target path

# create

use `ln -s`:

    echo a > a
    ln -s a b
    [ `cat b` = a ] || exit 1

#if if target is moved the link breaks

broken links are also known as *dangling links*

if a program tries to open them, it gets a permission error:

    echo a > a
    ln -s a b
    mv a c
    if cat b; then exit 1; fi

# check if path is symlink

symlinks are identified by system metadata.
programs can tell if a file is a symlink or not:

    touch a
    ln -s a b
    [ -L b ] || exit 1

# get path to which symlink points to

use `readlink`:

    touch a
    ln -s a b
    [ `readlink b` = a ] || exit 1

# relative vs absolute

symlinks can contain either relative paths or absolute paths

    touch a
    mkdir d
    ln -s a d/a

# what programs do when they see a symlink is up to them to decide

file content changes always affect the target of the link:

    touch a
    ln -s a b
    echo a > b
    [ `cat a` = a ] || exit 1

this is the most commont type of operation

file operations may use the link, or the link's content,
it depends on the program. For example `cp` could either
copy the content or the symlink itself.

symlinks have their own inode:

    touch a
    ln -s a b
    [ ! "`stat -c "%i" a`" = "`stat -c '%i' b`" ] || exit 1

it is therefore possible to make hardlinks of symlinks:

    touch a
    ln -s a b
    ln b c
    [ `readlink c` = a ] || exit 1

# permissions

symlinks always show 777 permission,
but this permission means nothing:

only the permissions and owners of target file
and its subdirs matter!

example: symlink to file

    touch f
    chmod 000 f
    ln -s f fln
    [ "$(stat -c "%A" fln)" = "lrwxrwxrwx" ] || exit 1

still cannont cat from link:

    if cat fln; then assert false; fi

trying to chmod the link, acts on the destination instead:

    chmod 444 f
    [ "$(stat -c "%A" f)"   = $'lr--r--r--' ] || exit 1
    [ "$(stat -c "%A" fln)" = $'lrwxrwxrwx' ] || exit 1

example: symlink to dir

    mkdir -m 777 d
    mkdir -m 777 d/d
    ln -ds d/d ddln
    chmod 000 d

cannot ls d/d even from ddln because no permission on d:

    if ls ddln; then exit 1; fi

exit 0

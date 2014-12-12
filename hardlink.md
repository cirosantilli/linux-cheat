# Hardlink

Points to an inode.

## Create

Create with `ln`:

    echo a > a
    ln a b

## Get inode of a file

With `stat`:

    echo a > a
    ln a b
    [ `stat -c '%i' a` = `stat -c '%i' b ` ] || exit 1

## mv

Unlike symlinks, even if you move any of the files, changes in one file reflect immediately on the other:

    echo a > a
    ln a b
    mkdir d
    mv b d
    echo b > d/b
    [ `cat a` = b ] || exit 1

## It is not efficient to find all paths of an inode

The only way to do that is searching every file on the system, if you have permissions...

The only way to check if two files are hardlinked is by comparing their inodes.

## Count

It is possible to tell how many hardlinks a file has with stat:

    stat -c '%h' f

Since the filesystem has to count this to be able to delete the file when the count reaches 0.

## Permissions

You must have read *and* write permissions to the file in order to make a hardlink to it:

    su a
    touch a
    chmod a 600
    sudo chown b a
    ln a aln
        #operation not permitted

This differs from copying where only read permission is enough.

This is because if you can access the hardlink to the file, then you can modify the file itself.

points to an inode, a filesystem address id,
analogous to what a c is to memory

#create

create with ln:

    echo a > a
    ln a b

#get inode

    echo a > a
    ln a b
    [ `stat -c '%i' a` = `stat -c '%i' b ` ] || exit 1

#mv

unlike symlinks, even if you move any of the files,
changes in one file reflect immediatelly on the other:

    echo a > a
    ln a b
    mkdir d
    mv b d
    echo b > d/b
    [ `cat a` = b ] || exit 1

#it is not efficient to find all paths of an inode

the only way to do that is searching every file on the system,
if you have permissions...

the only way to check if two files are hardlinked is by comparing their inodes.

#count

it is possible to tell how many hardlinks a file has with stat:

    stat -c '%h' f

since the filesystem has to count this to be able to delete the file
when the count reaches 0.

#permissions

you must have read *and* write premissions to the file in order to make a hardlink to it:

    su a
    touch a
    chmod a 600
    sudo chown b a
    ln a aln
        #operation not permitted

this differs from copying where only read permission is emough.

this is because if you can access the hardlink to the file,
then you can modify the file itself.

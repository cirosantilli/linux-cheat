TODO check what is POSIX or not.

All of the timestamps can be retrieved via a `sys_stat`, or via a `stat` shell call.

There are 3 widely supported timestamps (POSIX?)

- atime
- mtime
- ctime

And one timestamp with very little current support:

- btime

# atime

Access time.

Last time file or was accessed, for example via a `sys_read` or `sys_execve` or `sys_readdir`.

`sys_stat` does not change this date.

Examples:

`sys_read` updates atime:

    echo a > a
    stat a
    sleep 1
    cat a
    stat a

`sys_execve` updates atime:

    echo 'echo a' > a
    stat a
    sleep 1
    ./a
    stat a

`sys_readdir` updates atime of directories:

    mkdir d
    stat d
    sleep 1
    ls d
    stat d

# mtime

Modification time.

Last time the file or directory data was modified, for example via a `sys_write` call or file creation in the directory.

Those system calls do no modify the atime.

Those system calls also modify the ctime.

Metadata such as permissions and ownership are not considered.

Writing the same data twice updates mtime:

    echo a > a
    stat a
    echo a > a
    stat a

File creation updates mtime of directories:

    mkdir d
    stat d
    sleep 1
    touch d/a
    stat d
        #mtime updated

`sys_unlink` updates mtime of directories:

    mkdir d
    stat d
    touch d/a
    sleep 1
    rm d/a
    stat d
        #mtime updated

Only top level directory changes are considered, since only those are stored in the directory data:

    mkdir d
    mkdir d/d
    stat d
    sleep 1
    touch d/d/a
    stat d
        #mtime unchanged

# ctime

Change time.

Last time inode information was changed, for example permissions, owner, group.

Example:

    echo a > a
    stat a
    sleep 1
    chmod 777 a
    stat a
        #ctime changed
        #mtime same

# btime

Birth time.

Time of original creation of the file, not considering modifications.

Not POSIX nor widely supported.

    echo a > a
    stat a
    chmod 777 a
    stat a

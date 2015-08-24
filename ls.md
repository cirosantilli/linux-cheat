# ls

POSIX 7

List files in directories.

## l

Show lots of information:

    ls -l

Sample output:

    -rw-rw-r-- 1 ciro ciro  4 Feb 25 11:53 a
    1          2 3    4     5 6            7

1. file permissions. See permissions
2. for files, number of hardlinks. For directories, it is the number of subdirs + parent + self, the minimum being 2 therefore.
3. owner
4. group
5. size in bytes
6. last modified
7. filename

`ls` permissions can also have a trailing `+` in case of ACL: <http://serverfault.com/questions/227852/what-does-a-mean-at-the-end-of-the-permissions-from-ls-l>

`ls` is aware if its output goes to a pipe or not. if yes, automatically newline separates it:

    ls | cat

One per line:

    ls -1

`ls` a file:

    touch a
    [ "$(ls a)" = "a" ] || exit 1

    ls a dir:

    mkdir d
    touch d/a d/b
    [ "$(ls d)" = "$(printf 'a\nb\n')" ] || exit 1

    ls many dirs:

    mkdir d
    touch d/a d/b
    mkdir e
    touch e/a e/b
    ls d e

`-d`: list directory names only:

    mkdir d
    touch d/a d/b
    mkdir e
    touch e/a e/b
    [ "$(ls -d d e)" = "$(printf 'd\ne\n')" ] || exit 1

`-lL`: when showing symlinks, shows info to what is linked to

## Sort

Modification time (newest first):

    ls -t

Inode change:

    ls -tc

File access:

    ls -tu

Reverse sort order:

    ls -tr

## GNU extensions

`-R`: recursive

    ls -R

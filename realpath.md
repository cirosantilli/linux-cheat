# realpath

`realpath` package on Ubuntu.

Resolve all symbolic links and `.` and `..` entries of a path recursively.

Prefer `readlink` which is more widespread by default in distros.

    mkdir a
    ln -s a b
    cd a
    touch a
    ln -s a b
    cd ..
    realpath ./b/b

Output:

    = "`pwd`/a/a"

    readlink -f

Same as:

    readlink ./b/b

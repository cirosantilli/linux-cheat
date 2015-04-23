# pathchk

Coreutils: <https://www.gnu.org/software/coreutils/manual/html_node/pathchk-invocation.html#pathchk-invocation>

Check if path is portable across POSIX systems:

    pathchk -p 'a' || exit 1
    pathchk -p '\\' && exit 1

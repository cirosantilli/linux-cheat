# mktemp

Create temporary files in the temporary directory.

Coreutils: <https://www.gnu.org/software/coreutils/manual/html_node/mktemp-invocation.html>

Creates a temporary file in `/tmp/`:

    f="$(mktemp)"
    echo "$f"
    assert test -f "$f"
    rm "$f"

Directory:

    d="$(mktemp -d)"
    echo "$f"
    assert test -d "$d"
    rm -r "$d"

Custom name template:

    f="$(mktemp --tmpdir abcXXXdef)"
    assert echo "$f" | grep -E 'abc...def'
    assert test -f "$f"
    rm "$f"

Must use `--tmpdir` with template or else file is created in current dir.

# read

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/read.html>

Read from stdin and store lines in shell variables.

Must be a shell built-in, since it modifies shell variables directly

Get string from user into variable `a`:

    read a
    echo "$a"

Cannot write with pipe into read because the pipe spawns a sub-shell, which cannot modify a variable in its parent shell: <http://stackoverflow.com/questions/13763942/bash-why-piping-input-to-read-only-works-when-fed-into-while-read-const>

    a=a
    echo b | read a   `read a` is executed in a subshell!
    [ $a = a ] || exit 1

Creating a subshell does work however:

    echo 'abc' | ( read b; [ "$b" = 'abc' ] || exit 1 ) || echo fail

Redirection however does work:

    read a < <(printf 'abc')
    [ "$a" = 'abc' ] || exit 1

This is why while combos also work:

    while read l; do
      echo "$l"
    done < <( printf "a\nb\na b\n" )

Read from file descriptor line-wise and assign to variable.

## Applications

Read file line-by-line:

    while read l; do
    echo "$l";
    done < "$f"

Read stdout line-by-line:

    while read l; do
        echo "$l"
    done < <( echo -e "a\nb\na b" )

Split into fields:

    IFS_OLD="$IFS"
    while IFS=' : ' read f1 f2
    do
    echo "$f1 $f2"
    done < <( echo -e "a : b\nc : d" )
    IFS="$IFS_OLD"

## GNU extensions

`-p` print a prompt message:

    read -p 'Enter string: ' s
    echo "You entered: $s"

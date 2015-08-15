## paste

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/paste.html>

Shows files side by side line by line.

Tabulation is based on the tab character, so having lines longer than the tab make this unreadable by default:

    printf '1 a\n' > a
    printf '1 b\n2 b b\n' > b
    printf '1 c\n2 c c\n3 c c c\n' > c
    paste a b c

Output:

    1 a     1 b     1 c
            2 b b   2 c c
                    3 c c c

POSIX requires `-` to be one of the arguments for stdin to be read.

## Join lines of file with custom separator

<http://stackoverflow.com/questions/8522851/concise-and-portable-join-on-the-unix-command-line>

Seems to be the best tool for it:

    [ "$(printf 'a\nb\nc\n' | paste -sd, -)" = 'a,b,c' ] || exit 1

`tr` also works somewhat, but you have to deal with the last separator.

## Join every two lines

<http://stackoverflow.com/questions/8987257/concatenating-every-other-line-with-the-next>

    [ "$(printf 'a\nb\nc\nd\n' | paste -d, - -)" = "$(printf 'a,b\nc,d')" ] || exit 1

`- -` works only for stdin: <http://stackoverflow.com/questions/8987257/concatenating-every-other-line-with-the-next#comment50617700_8987307>

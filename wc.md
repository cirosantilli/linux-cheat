# wc

POSIX 7

Does word, line, character and other similar counts.

Mnemonic: Word Count.

    [ "$(printf 'a\nb c\n'| wc)" = "      2       3       6" ] || exit 1

Meaning of output:

- `2`: newline count
- `3`: word count
- `6`: byte count

Options:

- `c`: bytes only
- `m`: chars only
- `l`: newlines only
- `L`: max line length only
- `w`: words only

To omit the filename: use stdin! <http://stackoverflow.com/questions/3746947/get-just-the-integer-from-wc-in-bash>

    wc <file

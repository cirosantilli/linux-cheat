# grep

POSIX 7

Select lines from stdin or files.

Don't use `egrep` and `fgrep` GNU variants, which are useless (can be easily achieved with `grep`) and deprecated.

Basic usage:

    [ "$(printf 'ab\ncd\n' | grep a)" = "ab" ] || exit 1
    printf 'a\nb\n' > f
    [ "$(grep a f)" = "ab" ] || exit 1

## Pattern

grep can use POSIX BRE (default) and POSIX ERE via `-E`.

Don't forget: BRE is deprecated.

Perl regex is not specified in POSIX, but the GNU implementation offers the option, but states in the man that it is highly experimental (from which we deduce they are not relying on Perl itself).

## i

Case insensitive:

    printf 'A\nB\n' | grep -i a

Output:

    A

## E

Find with ERE:

    printf 'a\nb\n' | grep -E '(a|b)'

Much saner and more powerful than BREs.

### Application: filter lines by length

`N` characters or more:

    [ "$(printf 'a\naa\n' | grep -E '.{2,}')" = "aa" ] || exit 1

Less than `N` characters:

    [ "$(printf 'a\naa\n' | grep -Ev '.{2,}')" = a ] || exit 1

Not very fast, but best golfer I have seen so far. `sed` for inline.

## F

Fixed, that is, literal non BRE search:

    printf '*\n' | grep -F '*'

Output:

    *

## v

Invert: print lines that don't match:

    [ "$(printf 'ab\ncd\n' | grep -v a)" = "cd" ] || exit 1

Application:

Remove line from file:

    f=
    l="^$"
    tmp="`mktemp`"
    grep -v "$l" "$f" > "$tmp"
    mv "$tmp" "$f"

## Exit status

0 if at least one match, 1 otherwise.

    echo a | grep -q b && assert false
    echo a | grep -q a || assert false

## q

Quiet, suppress stdout.

Useful if you only want the exit status to decide if match exists or not.

Application:

Append line to file only if it is not there already:

    f=""
    l=""
    grep -q "^$l$" "$f" || echo "$l" >> "$f"

Very useful for files that have unordered sets of things separated by newlines.

## l

Show only matching filenames.

Specially useful with `-r`.

## c

Count how many lines match

    printf 'a\na\n' | grep -c a

Output:

    2

## e

Multiple criteria OR. Mnemonic: Either.

All patterns are BRE:

    printf 'a\nb\n' | grep -e 'a' -e 'b'

All patterns are ERE:

    printf 'a\nb\n' | grep -E -e 'a' -e 'b'

## n

Show matching line Numbers

## f

Grep for either of lines of an input file.

	printf "ab\ncd\n" > f
	[ "$(printf "0ab\n1ef\n2cd" | grep -f f)" = "$(printf "0ab\n2cd\n")" ] || exit 1

## GNU extensions

### r

Recurse, print filenames before batches.

*Very* useful to search for definitions in source code on interactive sessions
where portability does not matter.

No more `find . -type f | xargs` !

    grep -r 'a' .

### A

Also print `n` lines following the match:

    assert [ "`printf 'a\nb\n' | grep -A1 a`" = $'a\nb' ]

#### application

Get the nth line after matching line:

    assert [ "`printf 'a\nb\n' | grep -A1 a | tail -n1`" = $'b' ]

### B

Before. Contrary of `-A`.

    assert [ "`printf 'a\nb\n' | grep -B1 b`" = $'a\nb' ]

### color

Colors matching parts of strings.

Accept all and highlight pattern:

    grep --color -E "pattern|$" file

### o

Only print matches.

## Multiline searches

Impossible: <http://stackoverflow.com/questions/152708/how-can-i-search-for-a-multiline-pattern-in-a-file>

Use `pcregrep` instead.

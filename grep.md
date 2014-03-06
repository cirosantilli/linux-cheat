POSIX 7

Select lines from stdin or files.

Don't use `egrep` and `fgrep` GNU variants, which are useless (can be easily achieved with `grep`) and deprecated.

    echo $'a\nb' | grep a
    echo $'a\nb' > f
    grep a f

Output:

    a

#Pattern

grep can use POSIX BRE (default) and POSIX ERE via `-E`.

Don't forget: BRE is deprecated.

Perl regexp is not specified in POSIX, but the GNU implementation offers the option,
but states in the man that it is highly experimental (from which we deduce they are not relying on Perl itself).

#i

Case insensitive:

    echo $'A\nB' | grep -i a

Output:

    A

##E

Find with ERE:

    echo $'a\nb' | grep -E '(a|b)'

Much saner and more powerful than BREs.

##F

Fixed, that is, literal non BRE search:

    echo $'*' | grep -F '*'

Output:

    *

#v

Invert. print lines that don't match.

    echo $'ab\ncd' | grep -v a

Output:

    cd

Application:

Remove line from file:

    f=
    l="^$"
    tmp="`mktemp`"
    grep -v "$l" "$f" > "$tmp"
    mv "$tmp" "$f"

#Exit status

0 if at least one match, 1 otherwise.

    echo a | grep -q b && assert false
    echo a | grep -q a || assert false

#q

Quiet, suppress stdout.

Useful if you only want the exit status to decide if match exists or not.

Application:

Append line to file only if it is not there already:

    f=""
    l=""
    grep -q "^$l$" "$f" || echo "$l" >> "$f"

Very useful for files that have unordered sets of things separated by newlines.

#l

Show only matching filenames.

Specially useful with `-r`.

#c

Count how many lines match

    echo $'a\na' | grep -c a

Output:

    2

#e

-e: multiple criteria ORed. Mnemonic: Either.

All patters are BRE:

    echo $'a\nb' | grep -e 'a' -e 'b'

All patters are ERE:

    echo $'a\nb' | grep -E -e 'a' -e 'b'

#n

Show matching line Numbers

#GNU extensions

##r

Recurse, print filenames before batches.

*Very* useful to search for definitions in source code on interactive sessions
where portability does not matter.

No more `find . -type f | xargs` !

    grep -r 'a' .

##A

also print n lines following the match

    assert [ "`echo $'a\nb' | grep -A1 a`" = $'a\nb' ]

###application

get the nth line after matching line:

    assert [ "`echo $'a\nb' | grep -A1 a | tail -n1`" = $'b' ]

##B

Before. Contrary of `-A`.

    assert [ "`echo $'a\nb' | grep -B1 b`" = $'a\nb' ]

##color

Colors matching parts of strings.

Accept all and highlight pattern:

    grep --color -E "pattern|$" file

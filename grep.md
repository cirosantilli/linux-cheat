posix 7

select lines from stdin or files

dont use egrep and fgrep variations,
which are useless and deprecated

    echo $'a\nb' | grep a
    echo $'a\nb' > f
    grep a f

Output:

    a

#pattern

grep can use POSIX BRE and POSIX ERE

don't forget: BRE is deprecated

perl regexp is not specified in POSIX

#-i

case insensitive:

    echo $'A\nB' | grep -i a

Output:

    A

##-E

Find with ERE:

    echo $'a\nb' | grep -E '(a|b)'

Much saner and more powerful than BREs.

##-F

Fixed, that is, literal non BRE search:

    echo $'*' | grep -F '*'

Output:

    *

#-v

invert. print lines that don't match.

    echo $'ab\ncd' | grep -v a

Output:

    cd

##application

remove line from file

    f=
    l="^$"
    tmp="`mktemp`"
    grep -v "$l" "$f" > "$tmp"
    mv "$tmp" "$f"

#exit status

0 if at least one match, 1 otherwise.

    echo a | grep -q b && assert false
    echo a | grep -q a || assert false

#-q

quiet, suppress stdout

useful if you only want the exit status

##application

append line to file
if it is not there already

    f=""
    l=""
    grep -q "^$l$" "$f" || echo "$l" >> "$f"

very useful for files that have unordered
sets of things separated by newlines

#-c

count how many lines match

    echo $'a\na' | grep -c a

Output:

    2

#-e

-e: multiple criteria ORed. Mnemonic: Either.

all patters are BRE:

    echo $'a\nb' | grep -e 'a' -e 'b'

all patters are ERE:

    echo $'a\nb' | grep -E -e 'a' -e 'b'

#-n

show matching line Numbers

#gnu extensions

##-r

Recurse, print filenames before batches.

*Very* useful to search for definitions in source code on interactive sessions
where portability does not matter.

No more `find . -type f | xargs` !!

    grep -r 'a'

##-A

also print n lines following the match

    assert [ "`echo $'a\nb' | grep -A1 a`" = $'a\nb' ]

###application

get the nth line after matching line:

    assert [ "`echo $'a\nb' | grep -A1 a | tail -n1`" = $'b' ]

##-B

Before. Contrary of `-A`.

    assert [ "`echo $'a\nb' | grep -B1 b`" = $'a\nb' ]

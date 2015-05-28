# POSIX Regular expressions

<http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html>

See also:

    man 7 regex

POSIX specifies are two types of regular expressions:

- basic (RE)
- extended (ERE)

Basic is deprecated, so don't use it if you can avoid it.

Unlike Perl regular expressions which are super powerful, POSIX regexes really are equivalent in power to mathematical regular expressions <https://en.wikipedia.org/wiki/Regular_expression#Formal_definition>. This makes them much less powerful, and potentially much more efficient to implement, and easier to learn.

Some POSIX utilities such as `grep` use BREs by default (backwards compatibility) but can use EREs with an option.

Others like `sed` only allow BREs, so you still need to learn them.

## BRE

<http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03>

BREs have special:

- `^` and `$` anchors
- `[ab]` character classes, including negated `[^ab]`
- `.` matches all
- `*` repeats last expression: `.*`, `[ab]*`.

### Predefined character classes

They enclosed in `[::]` inside a `[]`. Example:

    printf 'a\nb\n' | grep -E '[[:alpha:]]'

Full list:

    alnum       digit       punct
    alpha       graph       space
    blank       lower       upper
    cntrl       print       xdigit

Perl like character classes such as `\s` are not present. They may be provided as GNU extensions like `\s` in `sed`.

## ERE

<http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_04>

The main difference is that EREs add more Perl-like special characters.

EREs add:

- `(a|b)` alternation
- `a{1,3}` repetition count
- `a+` at least one
- `a?` one or zero.

Convenient character classes like `\s` are still not present.

Examples:

    printf 'a\nb\n'   | grep -E '(a|b)'
    printf 'a\nb\n'   | grep -E 'a*'
    printf 'a\nb\n'   | grep -E 'a?'
    printf 'a\nb\n'   | grep -E 'a+'
    printf 'a\nb\n'   | grep -E '^a$'
    printf 'a\nb\n'   | grep -E 'a{1,2}'
    printf 'aa\nab\n' | grep -E '(a)\1'
    printf 'a\nb\n'   | grep -E '.'
    printf 'a\nb\n'   | grep -E '[[:alpha:]]'
    printf 'a\nA\n'   | grep -E '[[:upper:][:lower:]]'`" = $'a\nA' ]

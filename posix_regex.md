    man 7 regex

posix specifies are two types of regexes:

- basic (RE)
- extended (ERE)

basic is deprecated, so don't use it

it is useful to learn since many posix compliant shell utilities may use
them but not perl regexes, for example `grep` or `sed`.

# ERE

## examples

    echo $'a\nb'    | grep -E '(a|b)'
    echo $'a\nb'    | grep -E 'a*'
    echo $'a\nb'    | grep -E 'a?'
    echo $'a\nb'    | grep -E 'a+'
    echo $'a\nb'    | grep -E '^a$'
    echo $'a\nb'    | grep -E 'a{1,2}'
    echo $'aa\nab'  | grep -E '(a)\1'
    echo $'a\nb'    | grep -E '.'
    echo $'a\nb'    | grep -E '[[:alpha:]]'
    echo $'a\nA'    | grep -E '[[:upper:][:lower:]]'`" = $'a\nA' ]

## predefined character classes

is the main difference between those and perl (except for very magic perl regex options)

they enclosed in `[::]` inside a `[]`. example:

    echo $'a\nb'    | grep -E '[[:alpha:]]'

full list:

    alnum       digit       punct
    alpha       graph       space
    blank       lower       upper
    cntrl       print       xdigit

in perl these are backlash escaped chars, much shorter to write...

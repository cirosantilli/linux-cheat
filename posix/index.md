aka: Portable Operating System Interface for uniX.

aka: Single Unix specification (SUS)

# sources

- Matthew; Stones - Beginning Linux Programming <http://www.amazon.com/Beginning-Linux-Programming-Neil-Matthew/dp/0470147628>

    very good intro do many of POSIX utilities

    very interesting examples and topics

# intro

an operating system standardization by both IEEE and `the open group`
(merger of the `Open software foundation` with `X/Open`)

currently, gnu/linux and mac systems are largely posix compliant but not certified,
windows is not largely compliant.

the specification if free to view

has several versions. The last at the time of writting was made in 2008

POSIX issue 7: IEEE formal name: `IEEE Std 1003.1-2008`
highly recommended link: http://pubs.opengroup.org/onlinepubs/9699919799/

Single UNIX Specification, Version 4: http://www.unix.org/version4/

# the open group

major open group supporters whose major supporters include:

Fujitsu, Oracle, Hitachi, HP, IBM,
US Department of Defense, NASA

therefore some of the top users/creators of software

# examples of what posix specifies

## shell command language

a shell language including almost all the basic `bash` syntax.

`bash` is copmliant with extensions

## shell utilities

utilities that should be available to the shell
such as programs in path or shell builtins

examples:

- cd
- ls
- cat
- mkdir

and tons of others which most people never heard of

## system interface

standard c interfaces to the system

they allow for operations such as:

- threads
- ipc
- filesystem operations
- user/group info
- maths: `cos`, `sin()`
- path operations: `basename()`, `dirname()`

it does not however specify the *exact* system calls,
and those are then implemented using a given os system calls.

however many of the linux system calls rassemble those
closely because of the complience

## directory structure

very small, contains:

- `/`
- `/tmp`
- `/dev/null`

## envinronment variables

posix defines some standard enviroment variables which every system should have

in posix 7, those are defined in: Base Definitions > Enviroment Variables

sample variables

- `PATH`
- `HOME`
- `PWD`
- `TMPDIR`
- `COLUMNS` and `LINES`: current width of terminal

default program variables:

- `SHELL`: this is *not* the current shell! it conatains the path of the defualt shell
- `TERM`: analogous to shell
- `EDITOR`
- `PAGER`

## regexp

    man 7 regex

posix specifies are two types of regexes:

- basic (RE)
- extended (ERE)

basic is deprecated, so don't use it

it is useful to learn since many posix compliant shell utilities may use
them but not perl regexes, for example `grep` or `sed`.

### examples

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

### predefined character classes

is the main difference between those and perl (except for very magic perl regex options)

they enclosed in `[::]` inside a `[]`. example:

    echo $'a\nb'    | grep -E '[[:alpha:]]'

full list:

    alnum       digit       punct
    alpha       graph       space
    blank       lower       upper
    cntrl       print       xdigit

in perl these are backlash escaped chars, much shorter to write...

## utility command line interface

suggests the following format for documenting clis:

    utility_name[-a][-b][-c option_argument][-d|-e][-f[option_argument]][operand...]

a few of the most interesting suggests for argument and utility name syntax:

- utility names are *lowercase* alphanum

- options start with one hyphen `-`

- options contain **a single** char only. Do not allow multichar options.

    This is notably not followed by the GNU convention of double hyphen for multichar
    options `--optionname`.

    Or even worse by some programs in the wild which use `-option`...

- `--` marks the last of the options
- `-` means stdin/stdout when the utility expects a filename as argument
- `-W` is reserved for vendor options

# TODO

- understand difference between the two: http://unix.stackexchange.com/questions/14368/difference-between-posix-single-unix-specification-and-open-group-base-specifi

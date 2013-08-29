aka: Portable Operating System Interface for uniX.

aka: Single Unix specification (SUS)

#sources

- Matthew; Stones - Beginning Linux Programming <http://www.amazon.com/Beginning-Linux-Programming-Neil-Matthew/dp/0470147628>

    very good intro do many of POSIX utilities

    very interesting examples and topics

#intro

An operating system standardization by both IEEE and `the open group`
(merger of the `Open software foundation` with `X/Open`)

Currently, gnu/linux and mac systems are largely posix compliant but not certified,
windows is not largely compliant.

The specification if free to view.

Has several versions. The last at the time of writting was made in 2008

POSIX issue 7: IEEE formal name: `IEEE Std 1003.1-2008`
highly recommended link: http://pubs.opengroup.org/onlinepubs/9699919799/

Single UNIX Specification, Version 4: http://www.unix.org/version4/

#the open group

major open group supporters whose major supporters include:

Fujitsu, Oracle, Hitachi, HP, IBM,
US Department of Defense, NASA

therefore some of the top users/creators of software

#examples of what posix specifies

##shell command language

a shell language including almost all the basic `bash` syntax.

`bash` is copmliant with extensions

##shell utilities

Utilities that should be available to the shell
( either as programs in path or shell builtins, this is not specified ).

Examples:

- cd
- ls
- cat
- mkdir
- c99 and fortr77: compiler interfaces for C99 and fortran77!

and tons of others which most people never heard of

##system interface

Standard C interfaces to the system.

They allow for operations such as:

- threads
- ipc
- filesystem operations
- user/group info
- maths: `cos`, `sin()`
- path operations: `basename()`, `dirname()`

It does not however specify the *exact* system calls,
and those are then implemented using a given os system calls.

However many of the linux system calls rassemble those
closely because of the complience, so when you learn the POSIX interface
you are already learning the Linux interface too.

In most Linux, the POSIX C interface is implemented as part of `glibc`,
which also implements ANCI libc and Linux extensions.

##directory structure

very small, contains:

- `/`
- `/tmp`
- `/dev/null`

##envinronment variables

In POSIX 7, those are defined in: Base Definitions > Enviroment Variables.

POSIX specifies:

- a few envioment variables and their functions

- many enviromnt variables which it is *unwise* (quote) to override because
    they are frequently used in implementations, but does not specify their exact function.

###fixed functions

The following variables have fixed purposes in POSIX 7:

- `PATH`
- `HOME`
- `PWD`
- `TMPDIR`
- `COLUMNS` and `LINES`: current width of terminal
- `SHELL`: this is *not* the current shell! it conatains the path of the defualt shell
- `TERM`: analogous to shell

###use with caution

The following variables don't have fixed purposes, but POSIX says that they must be used with caution:

- `EDITOR`: default text editor
- `PAGER`: default pager program ( `more`, `less`, etc. )
- `PPID`: PID of parent process

##regexp

    man 7 regex

posix specifies are two types of regexes:

- basic (RE)
- extended (ERE)

basic is deprecated, so don't use it

it is useful to learn since many posix compliant shell utilities may use
them but not perl regexes, for example `grep` or `sed`.

###examples

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

###predefined character classes

is the main difference between those and perl (except for very magic perl regex options)

they enclosed in `[::]` inside a `[]`. example:

    echo $'a\nb'    | grep -E '[[:alpha:]]'

full list:

    alnum       digit       punct
    alpha       graph       space
    blank       lower       upper
    cntrl       print       xdigit

in perl these are backlash escaped chars, much shorter to write...

##utility command line interface

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

#TODO

- understand difference between the two: http://unix.stackexchange.com/questions/14368/difference-between-posix-single-unix-specification-and-open-group-base-specifi

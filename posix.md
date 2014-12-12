# POSIX

For a cheat on the POSIX C API and all the concepts necessary to understand it see:
<https://github.com/cirosantilli/cpp/tree/99ad8ab9aee7bf2d8c47c9e25f4631eddb556ccf/posix>

POSIX command line utilities shall not be discussed here because it is better to group utilities together with other non-POSIX utilities which have similar functions, for example discussing both `kill` (POSIX) and `killall` (non-POSIX) side by side.

POSIX means: `Portable Operating System Interface for uniX`.

POSIX is also known as: Single Unix specification (SUS)

## Sources

-   <http://www.amazon.com/Beginning-Linux-Programming-Neil-Matthew/dp/0470147628>

    Matthew; Stones - Beginning Linux Programming.

    Very good intro do many of POSIX utilities with interesting examples and topics.

## Introduction

An operating system standardization by both IEEE and `the open group` (merger of the `Open software foundation` with `X/Open`)

Currently, GNU/Linux and mac systems are largely POSIX compliant but not certified, windows is not largely compliant.

The specification if free to view.

Has several versions.

POSIX issue 7: IEEE formal name: `IEEE Std 1003.1-2008` highly recommended link: <http://pubs.opengroup.org/onlinepubs/9699919799/>

Single UNIX Specification, Version 4: <http://www.unix.org/version4/>

## The Open Group

Major open group supporters whose major supporters include:

- Fujitsu
- Oracle
- Hitachi
- HP
- IBM,
- US Department of Defense
- NASA

Therefore some of the top users/creators of software.

## Examples of what POSIX specifies

### Shell command language

A shell language including almost all the basic `bash` syntax.

`bash` is compliant with extensions

### Utilities

Utilities that should be available to the shell (either as programs in path or shell builtins, this is not specified).

Examples:

- `cd`
- `ls`
- `cat`
- `mkdir`
- `c99` and `fortr77`: compiler interfaces for C99 and Fortran 77!

and tons of others which most people never heard of

### System interfaces

Standard C interfaces to the system.

They allow for operations such as:

- threads
- IPC
- filesystem operations
- user/group info
- maths: `cos`, `sin()`
- path operations: `basename()`, `dirname()`

It does not however specify the *exact* system calls, and those are then implemented using a given OS system calls.

However many of the Linux system calls resemble those closely because of the compliance, so when you learn the POSIX interface you are already learning the Linux interface too.

In most Linux, the POSIX C interface is implemented as part of `glibc`, which also implements ANSI libc and Linux extensions.

### Directory structure

<http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap10.html#tag_10>

Specifies very few directories:

- `/`
- `/tmp`
- `/dev/null`
- `/dev/tty`
- `/dev/console`

Extended notably by the FHS.

### Environment variables

In POSIX 7, those are defined in: Base Definitions > Environment Variables.

POSIX specifies:

- a few environment variables and their functions

- many environment variables which it is *unwise* (quote) to override because they are frequently used in implementations, but does not specify their exact function.

The following variables have fixed purposes in POSIX 7:

- `PATH`
- `HOME`
- `PWD`
- `TMPDIR`
- `COLUMNS` and `LINES`: current width of terminal
- `SHELL`:               this is *not* the current shell! It contains the path of the default shell.
- `TERM`:                analogous to shell

The following variables determine the locale applications should use:

- `LC_CTYPE`:    Character classification and case conversion.
- `LC_COLLATE`:  Collation order.
- `LC_MONETARY`: Monetary formatting.
- `LC_NUMERIC`:  Numeric, non-monetary formatting.
- `LC_TIME`:     Date and time formats.
- `LC_MESSAGES`: Formats of informative and diagnostic messages and interactive responses.

They are defined at: <http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap07.html>
POSIX also offers interfaces to modify those variables. The exact location where they are implemented
is not specified. E.g., on Ubuntu 14.04, they are stored under `/etc/default/locale`.

The following variables don't have fixed purposes, but POSIX says that they must be used with caution:

- `EDITOR`: default text editor
- `PAGER`: default pager program ( `more`, `less`, etc. )
- `PPID`: PID of parent process

### Regular expressions

    man 7 regex

POSIX specifies are two types of regular expressions:

- basic (RE)
- extended (ERE)

Basic is deprecated, so don't use it.

Some POSIX utilities such as `grep` or `sed` use BREs by default (backwards compatibility) but can use EREs with an option.

#### BRE vs ERE

The main difference is that EREs add more Perl-like special characters.

BREs have special:

- `^` and `$` anchors
- `[ab]` character classes, including negated `[^ab]`
- `.` matches all
- `*` repeats last expression: `.*`, `[ab]*`.

EREs add:

- `(a|b)` alternation
- `a{1,3}` repetition count
- `a+` at least one
- `a?` one or zero.

Perl like character classes such as `\s` are still very inconvenient in EREs: `[[:upper:][:lower:]]`.

Examples:

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

#### Predefined character classes

Is the main difference between those and Perl (except for very magic perl regex options).

They enclosed in `[::]` inside a `[]`. example:

    echo $'a\nb'    | grep -E '[[:alpha:]]'

Full list:

    alnum       digit       punct
    alpha       graph       space
    blank       lower       upper
    cntrl       print       xdigit

In Perl these are backlash escaped chars, much shorter to write...

### Command line interface

Suggests the following format for documenting CLIs:

    utility_name[-a][-b][-c option_argument][-d|-e][-f[option_argument]][operand...]

A few of the most interesting suggests for argument and utility name syntax:

-   utility names are *lowercase* alphanumeric.

-   options start with one hyphen `-`

-   options contain **a single** char only. Do not allow multi character options.

    One notable extension is the GNU convention of double hyphen for multi character options `--optionname`.

    Or even worse by some programs in the wild which use `-option`...

    Good discussion about command line interface conventions: <http://stackoverflow.com/questions/10818443/short-long-options-with-option-argument-is-this-some-sort-of-convention>

-   `--` marks the last of the options

-   `-` means stdin/stdout when the utility expects a filename as argument

-   `-W` is reserved for vendor options

### Exit status

[POSIX specifies that](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08):

-   `0`: success, all others for errors.

    It may seem counter intuitive to call 0 success since it is associated with false in C, but it is like that because there is only one type of success, and the other values indicate the exact cause of failure.

-   `127`: command not found. Try:

        asdfqwer
        echo $?

-   `126`: command found but not executable.

-   Values greater than 128 indicate that a process was terminated by a signal.

    GNU goes further and [specifies that](http://www.gnu.org/software/bash/manual/bashref.html#Exit-Status) when terminated by a signal, the exit status shall be 128 + the normal error status.

### Filenames

POSIX filenames are extremely restrictive: more than any modern operating system:

- only `a-zA-Z0-9._-` characters allowed
- maximum filename is 14 bits. 255 on Linux.

It also has rules which are enforced on all modern operating systems:

- reserved characters: slash `/` and `null`

## TODO

- understand difference between the two: http://unix.stackexchange.com/questions/14368/difference-between-posix-single-unix-specification-and-open-group-base-specifi

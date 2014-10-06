POSIX 7, with many GNU extensions.

Reads source files and generates a list of objects
that can be later searched.

Objects are things like C symbols: variable names,
function names, structure names, macros.

Therefore the output of this program is useful if you want to find
where something is defined in a large source code, such as the Linux kernel for example.

The output is both human and computer readable, therefore to use it you can either:

-   look at the file yourself and search.

    Useful when there are many possible definition places,
    and you might be able to guess the correct one by looking
    at the extra fields of the file.

-   use an editor such as VIM which has built-in functionalities
    that allows you to move cursor on top of the symbol, click something (`<C-]>`),
    and magically jump to the definition

    There could however be many candidate objects with the same name
    so you might have to loop a large list of tags.

    If that is the case, it might be easier to read the `tags` file directly.

#Basic usage

Put output on a file named `tags` on current dir:

    ctags main.c

Output to stdout:

    ctags -o - *.h

Recurse (GNU extension):

    ctags -R

Makes a single `tags` in current directory recursing into all child directories.

#Supported languages

POSIX requires only a that small set of C and FORTRAN symbols be processed.
GNU extends it considerably, and adds support for many languages.
The language list on the GNU implementation can be found with:

    ctags --list-languages

For me, this includes languages such as `C++`, `python`, `java` and many more.

#Objects of each language

To view what kinds of objects can be processed, which are processed by default,
and the one letter codes for each object type use:

    ctags --list-kinds=<lang>

where `<lang>` is taken from `ctags --list-languages`, possibly lowercased.

For example:

    ctags --list-kinds=c

Gives me the output:

    c  classes
    d  macro definitions
    e  enumerators (values inside an enumeration)
    f  function definitions
    g  enumeration names
    l  local variables [off]
    m  class, struct, and union members
    n  namespaces
    p  function prototypes [off]
    s  structure names
    t  typedefs
    u  union names
    v  variable definitions
    x  external and forward variable declarations [off]

These can be specified with:

    --<LANG>-kinds=[+|-]kinds

Example for the C language:

Only `c` and `d` objects:

    ctags -R --c-kinds=cd

Take defaults, add `c`, `d` and `f`, but remove `e`:

    ctags -R --c-kinds=+cd-e+f

One field which is tempting to remove for C is the `m`, which gives lots of id dupes
and is not very useful.

For example, you might want to find the definition of `x`,
and there are twenty structs which contain a member
named `x` besides the definition which you want.

This happens often on the Linux kernel code for example.

#Header extensions

Extensions interpreted as headers when doing `-R` for example:

    .h.H.hh.hpp.hxx.h++.inc.def

Can be modified with `-h`.

#Tag file format

    "%s\t%s\t/%s/\t%s\n", <identifier>, <filename>, <pattern>, <extension-field>

-   identifier: the id of the object

-   filename: file in which it is located

-   pattern:

    Command to find that line in the file.

    May be either a regex (`-N`, default) or a line number (`-n`).

    Advantage of regex: changes elsewhere in the file are unlikely to change the regex,
    but can easily change the exact line number.

    Advantage of line numbers: file is smaller.

-   extension-field

    GNU extension.

    Adds extra useful information to each type and scope.

    Can be controlled by the `--fields` option.

#Alternatives

- Cscope

##exuberant-ctags

Supports 55 languages

    exuberant-ctags a.c
    less tags

Seems to be the main Ubuntu package that offers a `ctags` utility.

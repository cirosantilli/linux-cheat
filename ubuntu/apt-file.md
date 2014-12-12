# apt-file

Search for and list package files. **very** useful to know: which package provides a missing file like a `bin/name` or `include/name.h`?

    sudo aptitude install apt-file
    apt-file update
    f=

## search

Search for file `"$F"` in packages.

    apt-file search "$f"

Literal full path substring match

Use Perl regex:

    apt-file search -x "a.c"

Combo: search for an executable called `a2x`:

    apt-file search bin/a2x

## Show

Shows files in package `p`:

    p=
    apt-file show "$p"

## Get info on packages before installing them

List package dependencies

    apt-cache depends $PKG

Find who depends on `$PKG` (reverse dependencies):

    sudo apt-rdepends -r $PKG

Get basic information about a package:

    apt-cache show $PKG

Get detailed information about a package:

    apt-cache showpkg $PKG

    sudo aptitude install debtags
    debtags tag ls $PKG

Package naming conventions:

    -dev:  headers and libs, no docs
    -doc:  documentation
    -test: tests


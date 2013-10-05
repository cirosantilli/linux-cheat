Info and cheatsheets on utils that work on Linux (and possibly other OSs too)
and Linux internals.

#Definition: utils

By *utils* we mean:

- programs
- programming languages
- libraries

either in the LSB or not.

#Other OS

Many of those tools may be cross platform or have very similar ports for
other OSs so the info here is also useful for other OS.
I have not however tested anything in any os except linux.

#This is the default utils repo

Those utils are kept in this repo because they don't deserve a repo of
their own because there is not enough info written on them.

The choice of Linux and not other OS is because and because Linux is the
best open source OS today.

#How to search for stuff

You have two friends. For filenames:

    find . -iname '*something'

And for inner sections:

    grep -r '#something'
    grep -r '#something'
    grep -r '#something'

`#` is consistently used as a header identifier.

Info and cheatsheets on utils that work on Linux (and possibly other OSs too) and Linux internals.

Most useful files:

- [utils.sh](utils.sh): main dump for utils that fit in no other category such as POSIX utilities.
- [ubuntu/install.sh](ubuntu/install.sh): software selection and install methods for Ubuntu. No tutorials.

#Definition: utils

By *utils* we mean:

- programs
- programming languages
- libraries

either in the LSB or not.

#Other OS

Many of those tools may be cross platform or have very similar ports for other OSs so the info here is also useful for other OS. I have not however tested anything in any OS except Linux.

#This is the default utils repo

Those utils are kept in this repo because they don't deserve a repo of their own because there is not enough info written on them.

The choice of Linux and not other OS is because and because Linux is the best open source OS today.

#How to search for stuff

For filenames:

    find . -iname '*something*'

And for stuff inside files:

    git grep '#something'
    git grep '##something'

`#` (`##` for files in which `#` indicates a comment) are consistently used as a keyword identifiers.

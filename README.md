Linux information and cheatsheets.

Includes utils that work on Linux, and possibly other OSs too, as well as Linux internals.

#Featured

- [ubuntu/install.sh](ubuntu/install.sh): software selection and install methods for Ubuntu. No tutorials.
- [utils.sh](utils.sh): main dump for utils that fit in no other category or are not large enough to get their own file, such as POSIX utilities.

Base standards:

- [linux.md](linux.md)
- [posix/](posix/)

Kernel related:

- [kernel/](kernel/)
- [system-call/](system-call/)

Initialization:

- [install-os.md](install-os.md)
- [boot.md](boot.md)
- [init.md](init.md)

Base topics:

- [desktop/](desktop/): X, XDG, GNOME, KDE and related utilities.
- [terminal.md](terminal.md)
- [compile/](compile/): compilation tools and file formats.
- [fs.sh](fs.sh): filesystem
- [net/](net/): networking

Media (audio, video, games, etc.) file types, viewers and editors:

- [media/](media)

#How to search for stuff

If you know what you are searching for, use the following methods to search by keyword.

For filenames:

    find . -iname '*something*'

And for stuff inside files:

    git grep '#something'
    git grep '##something'

`#` (`##` for files in which `#` indicates a comment) are consistently used as a keyword identifiers. E.g., in bash scripts, sections are labeled:

    ##concept

and not just:

    #concept

since those could be regular commented out code.

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

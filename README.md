Linux information and cheatsheets.

Includes utils that work on Linux, and possibly other OSs too, as well as Linux internals.

#Index

Important files:

- [ubuntu/install.sh](ubuntu/install.sh): Ubuntu install methods many programs.
- [utils.sh](utils.sh):                   dump of many utils that fit in no other category or are not large enough to get their own file. Many POSIX utilities.

Documentation viewers:

- [man.sh](man.sh)
- [info.sh](info.sh)

Base standards:

- [linux.md](linux.md): Linux, LSB.
- [posix.md](posix.md): POSIX standards.

Kernel related:

- [kernel/](kernel/)
- [system-call/](system-call/)

Initialization:

- [install-os.md](install-os.md): how to install a new OS.
- [boot.md](boot.md)
- [init.md](init.md):             System V, Upstart.

Base topics:

- [desktop/](desktop/):                       X, XDG, GNOME, KDE and related utilities.
- [filesystem.md](filesystem.md):             POSIX file permissions.
- [file-permissions.md](file-permissions.md): filesystem, hard disks, mounting, partitions.
- [special-files](special-files):             `proc`, `dev` and `sys` filesystems.
- [terminal.md](terminal.md):                 terminal emulators, ANSI escapes, control characters.

Media video, games, etc.) file types, viewers, editors, capture, synthesizers:

- [audio/](audio/):                 audio, music, sound.
- [book.md](book.md):               PDF, DJVU.
- [compression.md](compression.md): Zip, tar, gzip, 7z.
- [dict.md](dict.md):               dictionary formats.
- [game.md](game.md):               games, emulation.
- [file-share.md](files-share.md):  Soulseek, Dropbox.
- [image/](image/):                 images, photos.
- [markup](markup/):                Markdown, RST. Focus on command line interface and extensions.
- [video.md](video.md):             videos, films, subtitles.

Generic data formats:

- [json.md](json.md)
- [unicode.md](unicode.md)
- [xml/](xml/)

File and directory related utilities:

- [fdupes.md](fdupes.md)
- [find.md](find.md)
- [locate.md](locate.md)
- [ls.md](ls.md)
- [tree.md](tree.md)

Programming tools:

- [compile/](compile/): compilation process, dynamic libraries.
- [ack.sh](ack.sh)

[virtual-machine.md/](virtual-machine/): Vagrant, Docker.

Process control:

- [chroot.sh](chroot.sh)
- [env.sh](env.sh)
- [jobs.sh](jobs.sh)
- [lsof.md](lsof.md)
- [nice.sh](nice.sh)
- [nohup.sh](nohup.sh)
- [ps.sh](ps.sh)
- [pstree.sh](pstree.sh)
- [pwd.sh](pwd.sh)
- [sleep.sh](sleep.sh)
- [top.sh](top.sh)
- [wait.sh](wait.sh)

Other tools:

- [eval.sh](eval.sh)

Related subjects in other repositories:

- [networking](https://github.com/cirosantilli/net): networking tools and protocols: HTTP, SSH, curl Apache.

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

# ![logo](logo.jpg) Linux Cheat

Linux information and cheatsheets.

Includes Linux concepts and utilities that work on Linux, not necessarily in the LSB.

##Index

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

- [du.md](du.md)
- [fdupes.md](fdupes.md)
- [find.md](find.md)
- [locate.md](locate.md)
- [ls.md](ls.md)
- [tree.md](tree.md)

Programming tools:

- [compile/](compile/): compilation process, dynamic libraries.
- [ack.sh](ack.sh)

Process-related tools:

- [chroot.sh](chroot.sh)
- [env.sh](env.sh)
- [free.md](env.md)
- [htop.md](htop.md)
- [jobs.sh](jobs.sh)
- [lsof.md](lsof.md)
- [nice.sh](nice.sh)
- [nohup.sh](nohup.sh)
- [ps.md](ps.md)
- [pstree.sh](pstree.sh)
- [pwd.sh](pwd.sh)
- [sleep.sh](sleep.sh)
- [top.md](top.md)
- [wait.sh](wait.sh)

Other tools:

- [eval.sh](eval.sh)

[virtual-machine.md/](virtual-machine/): Vagrant, Docker.

Related subjects in other repositories:

- [C++ Cheat](https://github.com/cirosantilli/cpp-cheat): contains some compilation / language heavy subjects like the POSIX C API or generation of dynamic libraries.
- [Networking Cheat](https://github.com/cirosantilli/networking-tutorial): networking tools and protocols: HTTP, SSH, curl Apache.

##How to search for keywords

If you know what you are searching for, use the following methods to search by keyword.

For filenames:

    git ls-files | grep 'something'

And concepts inside file content:

    git grep '#something'

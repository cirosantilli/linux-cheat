# Linux Cheat ![logo](logo.jpg)

Linux information and cheatsheets.

Includes Linux concepts and utilities that work on Linux, not necessarily in the LSB.

## Index

Important files:

- [ubuntu/install](ubuntu/install.sh): Ubuntu install methods many programs.
- [utils](utils.sh): dump of many utils that fit in no other category or are not large enough to get their own file. Many POSIX utilities.

Documentation viewers:

- [man](man.sh)
- [info](info.sh)

Base standards:

- [Linux](linux.md): Linux, LSB.
- [POSIX](posix.md)

Kernel related:

- [Kernel](kernel/)
- [System Call](system-call/)

Initialization:

- [Install OS](install-os.md): how to install a new OS.
- [Boot](boot.md)
- [Init](init.md): System V, Upstart.

Base topics:

- [Desktop](desktop/): X, XDG, GNOME, KDE and related utilities.
- [Filesystem](filesystem.md): POSIX file permissions.
- [File permissions](file-permissions.md): filesystem, hard disks, mounting, partitions.
- [Special files](special-files.md): `proc`, `dev` and `sys` filesystems.
- [Terminal](terminal.md): terminal emulators, ANSI escapes, control characters.

Basic stream and file manipulation:

- [cat](cat.md)
- [head](head.md)
- [rev](rev.sh)
- [pr](pr.md)
- [tac](tac.md)
- [tail](tail.md)
- [truncate](truncate.md)

Pagers:

- [less](less.md)
- [more](more.md)
- [pg](pg.md)

Files, directories, partitions:

- [badblocks](badblocks.md)
- [blkid](blkid.md)
- [cp](cp.sh)
- [du](du.md)
- [e2fsck](e2fsck.md)
- [e2fsprogs](e2progs.md)
- [fdupes](fdupes.md)
- [find](find.md)
- [locate](locate.md)
- [ls](ls.md)
- [lsblk](lsblk.md)
- [Swap partition](swap-partition.md)
- [tree](tree.md)

Diff:

- [comm](comm.md)
- [cmp](cmp.md)

Binary data viewers:

- [hd](hd.md)
- [hexdump](hexdump.md)
- [od](od.md)

Programming:

- [ack](ack.sh)
- [Compile](compile/): compilation process, dynamic libraries.

Processes:

- [chroot](chroot.sh)
- [env](env.sh)
- [free](env.md)
- [htop](htop.md)
- [jobs](jobs.sh)
- [lsof](lsof.md)
- [nice](nice.sh)
- [nohup](nohup.sh)
- [ps](ps.md)
- [pstree](pstree.sh)
- [pwd](pwd.sh)
- [sleep](sleep.sh)
- [top](top.md)
- [ulimit](ulimit.md)
- [wait](wait.sh)

Date and time:

- [cal](cal.md)
- [ddate](ddate.md)
- [date](date.md)
- [hwclock](hwclock.md)
- [Time zone](time-zone.md)

Media video, games, etc.) file types, viewers, editors, capture, synthesizers:

- [Audio](audio/): audio, music, sound.
- [Book](book.md): PDF, DJVU.
- [Compression](compression.md): Zip, tar, gzip, 7z.
- [Dictionary](dictionary.md): dictionary formats.
- [Game](game.md): games, emulation.
- [Image](image/): images, photos.
- [Markup](markup/): Markdown, RST. Focus on command line interface and extensions.
- [Video](video.md): videos, films, subtitles.

File sharing:

- [Dropbox](dropbox.md)
- [Nicotine](nicotine.md)
- [Ubuntu One](ubuntu-one.md)
- [NFS](nfs.md) (WIP)
- [LDAP](ldap.md) (WIP)

User operations:

- [id](id.md)
- [usermod](usermod.md)

Generic data formats:

- [JSON](json.md)
- [Unicode](unicode.md)
- [XML](xml/)

Markup compilers:

- [Kramdown](kramdown/)
- [Pandoc](pandoc/)
- [RST](rst/)

Misc:

- [eval](eval.sh)

[Virtual machine](virtual-machine/): Vagrant, Docker.

Related subjects in other repositories:

- [Ubuntu Cheat](https://github.com/cirosantilli/ubuntu-cheat): Ubuntu specifics.
- [C++ Cheat](https://github.com/cirosantilli/cpp-cheat): contains some compilation / language heavy subjects like the POSIX C API or generation of dynamic libraries.
- [Networking Cheat](https://github.com/cirosantilli/networking-cheat): networking tools and protocols: HTTP, SSH, curl Apache.

## How to search for keywords

If you know what you are searching for, use the following methods to search by keyword.

For filenames:

    git ls-files | grep 'something'

And concepts inside file content:

    git grep '#something'

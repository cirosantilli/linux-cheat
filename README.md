# Linux Cheat ![logo](logo.jpg)

Linux information and cheatsheets.

Includes Linux concepts and utilities that work on Linux, not necessarily in the LSB.

## Index

- [ubuntu/install](ubuntu/install.sh): Ubuntu install methods many programs.
- [utils](utils.sh): dump of many utils that fit in no other category or are not large enough to get their own file. Many POSIX utilities.

Documentation viewers:

- [man](man.sh)
- [info](info.md)

Base standards:

- [POSIX](posix.md)
- [Linux](linux.md)
- [LSB](lsb.md)
- [FHS](fhs.md)
- [GNU](gnu.md)

Kernel related:

-   [Kernel](kernel/)
-   [System Call](system-call/)
-   [sysctl](sysctl.md)
-   [Special files](special-files.md): `proc`, `dev` and `sys` filesystems.
    - [proc filesystem](proc-filesystem.md)
    - [dev filesystem](dev-filesystem.md)

Initialization:

- [Install OS](install-os.md): how to install a new OS.
- [Boot](boot.md)
- [Init](init.md): System V, Upstart.

Base topics:

-   [Filesystem](filesystem.md): POSIX file permissions.
    - [Hardlink](hardlink.md)
-   [File permissions](file-permissions.md): filesystem, hard disks, mounting, partitions.
-   [Terminal](terminal.md): terminal emulators, ANSI escapes, control characters.
    - [Guake](guake.sh)

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

Text processing:

- [awk](awk.sh)
- [echo](echo.sh)
- [column](column.md)
- [cut](cut.sh)
- [Eclipse](eclipse.md)
- [expand](expand.md)
- [paste](paste.md)
- [printf](printf.sh)
- [sed](sed.sh)
- [tabs](tabs.md)
- [wc](wc.md)

Binary data viewers:

- [hd](hd.md)
- [hexdump](hexdump.md)
- [od](od.md)

Diff:

- [comm](comm.md)
- [cmp](cmp.md)
- [diff](diff.md)
- [wdiff](diff.md)

Files, directories:

-   [cp](cp.sh)
-   [dd](dd.md)
-   [du](du.md)
-   [fdupes](fdupes.md)
-   [find](find.md)
-   links:
    - [ln](ln.md)
    - [readlink](readlink.md)
    - [realpath](realpath.md)
-   [locate](locate.md)
-   [ls](ls.md)
-   [read](read.md)
-   [stat](stat.md)
-   [tree](tree.md)

File managers:

- [Krusader](krusader.md)
- [vifm](vifm.md)

Partitions, filesystems:

- [badblocks](badblocks.md)
- [blkid](blkid.md)
- [du](du.md)
- [e2fsck](e2fsck.md)
- [e2fsprogs](e2progs.md)
- [lsblk](lsblk.md)
- [swap partition](swap-partition.md)

[Compilation and libraries](compile.md):

- [GDB](gdb.md)
- [Library](library.md)

Programming:

- [ack](ack.sh)
- [ctags](ctags/)
- [Compile](compile/): compilation process, dynamic libraries.

Processes:

- [chroot](chroot.sh)
- [env](env.sh)
- [free](env.md)
- [htop](htop.md)
- [jobs](jobs.sh)
- [kill](kill.sh)
- [killall](killall.sh)
- [lsof](lsof.md)
- [nice](nice.sh)
- [nohup](nohup.sh)
- [ps](ps.md)
- [pstree](pstree.sh)
- [pwd](pwd.sh)
- [sleep](sleep.sh)
- [timeout](timeout.md)
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

-   [Audio](audio/): audio, music, sound.
-   [Book](book.md): PDF, DJVU.
-   [Dictionary](dictionary.md): dictionary formats.
-   [Game](game.md): games, emulation.
-   [Image](image/): images, photos.
    - [GIMP](gimp.md)
    - [gnuplot](gnuplot)
    - [imagemagick](imagemagick.md)
-   [Markup](markup/): Markdown, RST. Focus on command line interface and extensions.
-   [Video](video.md): videos, films, subtitles.

File sharing:

- [Dropbox](dropbox.md)
- [Nicotine](nicotine.md)
- [Ubuntu One](ubuntu-one.md)
- [NFS](nfs.md) (WIP)
- [LDAP](ldap.md) (WIP)

[Compression](compression.md):

- [7zip](7zip.md)
- [File Roller](file-roller.md)
- [RAR](rar.md)
- [gzip](gzip.md)
- [tar](tar.md)
- [zip](zip.md)

User operations:

- [id](id.md)
- [usermod](usermod.md)

[Desktop](desktop/): X, XDG, GNOME, KDE and related utilities.

-   Notifications
    - [libnotify](libnotify.md)
    - [zenity](zenity.md)
-   [update-alternatives](update-alternatives.md)
-   [xsel](xsel.md)
-   [xdg-open](xdg-open.md)
-   [xset](xset.md)

Generic data formats:

- [JSON](json.md)
- [XML](xml/)

Character encoding:

- [Unicode](unicode.md)
    - [iconv](iconv.sh)

Markup compilers:

- [Kramdown](kramdown/)
- [Pandoc](pandoc/)
- [RST](rst/)

[Virtual machine](virtual-machine/):

- [Docker](docker/)
- [Vagrant](vagrang/)

[Configuration automation](config-automation.md):

- [chef](chef/)
- [puppet](puppet.md)

Misc:

- [logrotate](logrotate.md)
- [factor](factor.md)
- [xargs](xargs.md)

## Related repositories

- [Ubuntu Cheat](https://github.com/cirosantilli/ubuntu-cheat): Ubuntu specifics.
- [C++ Cheat](https://github.com/cirosantilli/cpp-cheat): contains some compilation / language heavy subjects like the POSIX C API or generation of dynamic libraries.
- [Networking Cheat](https://github.com/cirosantilli/networking-cheat): networking tools and protocols: HTTP, SSH, curl Apache.

## How to search for keywords

If you know what you are searching for, use the following methods to search by keyword.

For filenames:

    git ls-files | grep 'something'

And concepts inside file content:

    git grep '#something'

## WIP

Compilation and libraries:

- [gcov](gcov.md)

Misc:

- [sys-filesystem](sys-filesystem.md)

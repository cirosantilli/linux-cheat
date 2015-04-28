# Linux Cheat ![logo](logo.jpg)

Linux information and cheatsheets.

Includes Linux concepts and utilities that work on Linux, not necessarily in the LSB.

1.  Related repositories
    1. [Ubuntu Cheat](https://github.com/cirosantilli/ubuntu-cheat)
    1. [C++ Cheat](https://github.com/cirosantilli/cpp-cheat): compilation / language heavy subjects: POSIX C API, dynamic libraries
    1. [Networking Cheat](https://github.com/cirosantilli/networking-cheat): networking tools and protocols HTTP, SSH, curl, Apache
1.  [utils](utils.sh) dump of many utilities. Being split up into separate files.
1.  Documentation viewers
    1. [man](man.sh)
    1. [info](info.md)
1.  Base standards
    1. [POSIX](posix.md)
    1. [Linux](linux.md)
    1. [LSB](lsb.md)
    1. [FHS](fhs.md)
    1. [GNU](gnu.md)
1.  Kernel related
    1. [Kernel](kernel/)
    1. [System Call](system-call/)
    1. [sysctl](sysctl.md)
    1. [Special files](special-files.md)
        1.  [proc filesystem](proc-filesystem.md)
        1.  [dev filesystem](dev-filesystem.md)
            1. [mknod](mknod.md)
1.  Initialization
    1. [Install OS](install-os.md): how to install a new OS
    1. [Boot](boot.md)
    1. [Init](init.md): System V, Upstart
1.  System information
    1.  [lsb_release](lsb_release.md)
    1.  [uname](uname.md)
    1.  Hardware
        [lspci](lspci.md)
1.  [Filesystem](filesystem.md)
    1.  [File permissions](file-permissions.md)
    1.  [Hardlink](hardlink.md)
    1.  [badblocks](badblocks.md)
    1.  [blkid](blkid.md)
    1.  [chown](chown.sh)
    1.  [chmod](chmod.sh)
    1.  [du](du.md)
    1.  ext filesystems
        1. [e2label](e2label.md)
        1. [e2fsck](e2fsck.md)
        1. [e2fsprogs](e2progs.md)
        1. [mke2fs](mke2fs.md)
    1.  [fdisk](fdisk.md)
    1.  [fuser](fuser.md)
    1.  [lsblk](lsblk.md)
    1.  [mktemp](mktemp.md)
    1.  [pathchk](pathchk.md)
    1.  [ramfs](ramfs.md)
    1.  [swap partition](swap-partition.md)
    1.  [UUID](uuid.md)
1. [Terminal](terminal.md): terminal emulators, ANSI escapes, control characters
    1. [Guake](guake.sh)
1.  Stream and file manipulation
    1. [cat](cat.md)
    1. [head](head.md)
    1. [rev](rev.sh)
    1. [pr](pr.md)
    1. [tac](tac.md)
    1. [tail](tail.md)
    1. [truncate](truncate.md)
1.  Pagers
    1. [less](less.md)
    1. [more](more.md)
    1. [pg](pg.md)
1.  Text processing
    1. [awk](awk.sh)
    1. [echo](echo.sh)
    1. [column](column.md)
    1. [cut](cut.sh)
    1. [Eclipse](eclipse.md)
    1. [expand](expand.md)
    1. [fold](fold.md)
    1. [paste](paste.md)
    1. [printf](printf.sh)
    1. [sed](sed.sh)
    1. [strings](strings.md)
    1. [tabs](tabs.md)
    1. [uniq](uniq.md)
    1. [wc](wc.md)
1.  Binary data viewers
    1. [hd](hd.md)
    1. [hexdump](hexdump.md)
    1. [od](od.md)
1.  Diff
    1. [comm](comm.md)
    1. [cmp](cmp.md)
    1. [diff](diff.md)
    1. [wdiff](diff.md)
1.  Files, directories
    1.  [cp](cp.sh)
    1.  [dd](dd.md)
    1.  [du](du.md)
    1.  [fdupes](fdupes.md)
    1.  [find](find.md)
    1.  links
        1. [ln](ln.md)
        1. [readlink](readlink.md)
        1. [realpath](realpath.md)
    1.  [locate](locate.md)
    1.  [ls](ls.md)
    1.  [read](read.md)
    1.  [stat](stat.md)
    1.  [tree](tree.md)
1.  File managers
    1. [Krusader](krusader.md)
    1. [vifm](vifm.md)
1.  Programming
    1. [ack](ack.sh)
    1. [ctags](ctags/)
1.  Processes
    1. [chroot](chroot.sh)
    1. [env](env.sh)
    1. [free](env.md)
    1. [htop](htop.md)
    1. [jobs](jobs.sh)
    1. [kill](kill.sh)
    1. [killall](killall.sh)
    1. [lsof](lsof.md)
    1. [nice](nice.sh)
    1. [nohup](nohup.sh)
    1. [ps](ps.md)
    1. [pstree](pstree.sh)
    1. [pwd](pwd.sh)
    1. [sleep](sleep.sh)
    1. [timeout](timeout.md)
    1. [top](top.md)
    1. [ulimit](ulimit.md)
    1. [wait](wait.sh)
1.  Date and time
    1. [cal](cal.md)
    1. [ddate](ddate.md)
    1. [date](date.md)
    1. [hwclock](hwclock.md)
    1. [Time zone](time-zone.md)
1.  Media video, games, etc.) file types, viewers, editors, capture, synthesizers
    1.  [Audio](audio/): music, sound
    1.  [Book](book.md): PDF, DJVU.
    1.  [Dictionary](dictionary.md): dictionary formats
    1.  [Game](game.md): games, emulation
    1.  [Image](image/): images, photos
        1. [GIMP](gimp.md)
        1. [gnuplot](gnuplot)
        1. [imagemagick](imagemagick.md)
    1.  [Markup](markup/): Markdown, RST. Focus on command line interface and extensions
    1.  [Video](video.md): videos, films, subtitles
1.  File sharing
    1. [Dropbox](dropbox.md)
    1. [Nicotine](nicotine.md)
1.  [Compression](compression.md)
    1. [7zip](7zip.md)
    1. [File Roller](file-roller.md)
    1. [RAR](rar.md)
    1. [gzip](gzip.md)
    1. [tar](tar.md)
    1. [zip](zip.md)
1.  User operations
    1. [id](id.md)
    1. [usermod](usermod.md)
1.  [Desktop](desktop/): X, XDG, GNOME, KDE and related utilities
    1.  Notifications
        1. [libnotify](libnotify.md)
        1. [zenity](zenity.md)
    1.  [update-alternatives](update-alternatives.md)
    1.  [xsel](xsel.md)
    1.  [xdg-open](xdg-open.md)
    1.  [xset](xset.md)
    1.  Screenshots
        1. [recordMyDesktop](recordMyDesktop.md)
        1. [xwd](xwd.md)
1.  Generic data formats
    1. [JSON](json.md)
    1. [XML](xml/)
1.  Character encoding
    1. [Unicode](unicode.md)
        1. [iconv](iconv.sh)
1.  Markup compilers
    1. [Kramdown](kramdown/)
    1. [Pandoc](pandoc/)
    1. [RST](rst/)
1.  [Virtual machine](virtual-machine/)
    1. [Docker](docker/)
    1. [User mode Linux](user-mode-linux.md)
    1. [Vagrant](vagrang/)
1.  [Configuration automation](config-automation.md)
    1. [chef](chef/)
    1. [puppet](puppet.md)
1.  Printing
    1.  [CUPS](cups.md)
        1. [lp](lp.md)
        1. [lpstat](lpstat.md)
        1. [lpoptions](lpoptions.md)
        1. [system-config-printer](system-config-printer.md)
1.  Math
    1.  [bc](bc.md)
    1.  [factor](factor.md)
    1.  [primes](primes.md)
    1.  [seq](seq.md)
    1.  [shuf](shuf.md)
    1.  Sorting
        1. [sort](sort.md)
        1. [tsort](tsort.md)
1.  Misc
    1. [cron](cron.sh)
    1. [logrotate](logrotate.md)
    1. [xargs](xargs.md)
1.  [Bibliography](bibliography.md)

## WIP

1.  Filesystem
    [eCryptfs](ecryptfs.md)
1.  [Hardware](hardware.md)
    1.  [lshw](lshw.md)
1.  [gcov](gcov.md)
1.  Misc
    1. [sys-filesystem](sys-filesystem.md)
1.  File sharing
    1. [NFS](nfs.md)
    1. [LDAP](ldap.md)

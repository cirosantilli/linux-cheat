linux an informal name for an operating systems which comply to the
[linux standar base (lsb)](lsb) specification of the [linux foundation][]

the central component of the linux operating system is the linux kernel,
released in 1991 by Linus Trovalds, however much of its core user space
software comes from the gnu project

which was created by linux trovalds in 1991

the major specification produced by the linux foundation is the
linux standard base (lsb): 
which specifies the minimum intefaces every linux system must offer.

the linux foundation also offers certification and compliance verification
tools for distribution developpers and application developpers.

the list of certified distributions and products can be found here:
https://www.linuxbase.org/lsb-cert/productdir.php?by_lsb.

# linux and gnu

[linux and gnu][]

the user space programs of linux are mostly inherited from the *gnu project*
which was created in 1983 by Richard Stallman.

for example, the following central components originate from gnu:

- gcc
- glibc
- bash

it seems that the gnu project is not officially called like that anymore,
and has transformed into the *free software foundation* (fsf) also founded by Stallman
TODO check

amongst the projects of the fsf is the *gnu operating system*.
they are also active in legal causes and activism for free software

the gnu operating system is developping its own kernel called *HUD*,
but the own project states that it is not yet ready for broad usage

the fsf insists on caling what most people call linux as GNU/linux,
which sounds quite reasonable considering they developed a great part of
the userspace core

the gnu software foundation is the creator and current maintainer
of the GPL licence, and mostly uses that licence for its software and
is the main enforcer of its infringements

# examples of what lsb specifies

## core

core c libraries

elf filetype

## c++

## interpreted languages

- python
- perl

## desktop

- x11, gtk+, and qt support
- jpeg, png support
- alsa (sound)

# fhs

filesystem hierarchy standard

maintained by the linux foundation

standard way for dir functions is called: standard directory architecture

like any classifications, many conventions are debatable and distro specific

/bin : executables in path
/sbin : executables used only for admin taks
/lib : .so shared libraries/python modules
/src : c source files
/include : c header files
/doc : documentation
/tmp : temporary files
/media : automatically mounted stuff
/mnt : manually mounted stuff
/etc : linux configuration files
/etc/default : default values of some configs
/dev
devices
represent hardware
/dev/sd.. and /dev/hd..
hard disk partitions. see <# hd>
/dev/sr.
cd/dvd
/dev/cdrom
/dev/cdrw
usually link to /dev/sr.
/dev/(sd|hd)..
/dev/input/by-id
now remove you mouse
mouse files dissapear!
/dev/tcp/localhost/25
check ports open/close
(echo >/dev/tcp/localhost/25) &>/dev/null && echo "TCP port 25 open" || echo "TCP port 25 close"
/proc
processes and sys info
<http://www.thegeekstuff.com/2010/11/linux-proc-file-system/>
numbered folders:
represent processes!
you can `sudo cat` all files, even if they say size 0!
/root : root user home
/usr : user installed/distribuiton installed/managed by package manager
/usr/share
system independent data (not compiled for an specific system type)
/usr/share/doc
documentation for libraries and executables
/usr/share/sounds
system sounds like beeps and warnings
/usr/src/linux-headers-X.Y.Z-WW
kernel
/usr/local : user installed, managed either by package managers (pip) or manually
/var
data that changes while system runs
/var/log/
program outputs
some important ones: <http://www.thegeekstuff.com/2011/08/linux-var-log-files/>
/var/log/messages
global system messages
mail, cron, daemon, kern, auth
ubuntu uses /var/log/syslog
/var/log/auth.log
user logins, including sudo
/var/log/dpkg.log
package install
/var/log/kern.log
kernel messages
/var/log/mail.log
/var/log/Xorg.x.log
failed login attempts:
/var/log/btmp
/var/log/faillog
/var/log/wtemp
login information
used by who and last
/lost+found : files recovered after system crash
/sys
non official
ubuntu: devices

## basename conventions

not in the fhs, but you should know about

### ^\.

hidden files

it is up to programs to decide how to treat them

### \.~$

backup file

### \.bak$

backup file

### \.orig$

original installation file

### \.d$

many theories, a plausible one:
differentiate `a.conf file` from `a.conf.d` dir
normally, all files in the `a.conf.d` dir will be sourced
as if they wre inside `a.conf`

[lsb]: http://www.linuxfoundation.org/collaborate/workgroups/lsb/download
[linux foundation]: http://www.linuxfoundation.org/

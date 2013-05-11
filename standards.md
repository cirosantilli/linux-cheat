linux is based on the following standards:

- posix

- linux standard base (lsb)

- file system hierarchy standard (fhs)

## posix

aka: Portable Operating System Interface for uniX.

aka: Single Unix specification (SUS)

TODO understand difference between the two: http://unix.stackexchange.com/questions/14368/difference-between-posix-single-unix-specification-and-open-group-base-specifi

an operating system standardization by both IEEE and `the open group`
(merger of the `Open software foundation` with `X/Open`)

currently, linux and mac are largely posix compliant but not certified,
windows is not largely compliant.

free standard

has several versions. The last at the time of writting was made in 2008

POSIX issue 7: IEEE formal name: `IEEE Std 1003.1-2008`: http://pubs.opengroup.org/onlinepubs/9699919799/
quite readable

Single UNIX Specification, Version 4: http://www.unix.org/version4/

### the open group

major open group supporters whose major supporters include:

Fujitsu, Oracle, Hitachi, HP, IBM,
US Department of Defense, NASA

therefore some of the top users/creators of software

### examples of what posix specifies

#### shell

a shell language. bash is compliant, with extensions.

utilities that should be available to the shell
such as programs in path or shell builtins

examples:

- cd
- ls
- cat
- mkdir

#### system interface

standard c interfaces to the system

they allow for operations such as:

- threads
- ipc
- filesystem operations
- user/group info

it does not however specify the *exact* system calls,
and those are then implemented using a given os system calls.

however many of the linux system calls rassemble those
closely because of the complience

## lsb

linux standard base

maintained by the linux foundation: http://www.linuxfoundation.org/collaborate/workgroups/lsb/download

###examples of what lsb specifies

#### core

core c libraries

elf filetype

#### c++

#### interpreted languages

- python
- perl

#### desktop

- x11, gtk+, and qt support
- jpeg, png support
- alsa (sound)

## fhs

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

### basename conventions

not in the fhs, but you should know about

#### ^\.

hidden files

it is up to programs to decide how to treat them

#### \.~$

backup file

#### \.bak$

backup file

#### \.orig$

original installation file

#### \.d$

many theories, a plausible one:
differentiate `a.conf file` from `a.conf.d` dir
normally, all files in the `a.conf.d` dir will be sourced
as if they wre inside `a.conf`

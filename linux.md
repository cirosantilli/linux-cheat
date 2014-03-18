Linux in informal terms can be either a computer system that:

- complies to the [Linux Standard Base (LSB)](lsb) which is the main standard maintained by the [Linux foundation][]

- uses the Linux kernel. TODO is this specified by the LSB? where? <http://unix.stackexchange.com/questions/75611/what-does-the-linux-standard-base-specify-about-the-kernel> 

The [LSB] specifies the minimum interfaces every Linux system must offer.

The central component of the Linux operating system is the Linux kernel, released in 1991 by Linus Trovalds, however much of its core user space software comes from the GNU project. For this reason Linux systems may also be called GNU/Linux. 

#Certification

The Linux foundation offers certification and compliance verification tools for distribution developers and application developers.

The list of certified distributions and products can be found here: <https://www.linuxbase.org/lsb-cert/productdir.php?by_lsb.>

Notable certified systems include:

- Ubuntu 9.4

    However not later versions up to time of writing

    [It seems that](http://askubuntu.com/questions/89125/does-ubuntu-follow-the-linux-standard-base-lsb) Ubuntu does not intend to fully comply on certain specific points, but only be highly compliant.

- Red Hat Enterprise Linux 6.0

#GNU

The user space programs of most Linux distributions are mostly inherited from the *GNU project* which was created in 1983 by Richard Stallman.

For example, the following central components originate from GNU:

- GCC
- glibc
- bash

It seems that the GNU project is not officially called like that anymore, and has transformed into the *free software foundation* (FSF) also founded by Stallman. TODO check

Amongst the projects of the FSF is the *gnu operating system*. they are also active in legal causes and activism for free software.

The GNU operating system is developing its own kernel called *HUD*, but the own project states that it is not yet ready for broad usage

The FSF insists on calling what most people call Linux as GNU/Linux, which sounds quite reasonable considering they developed a great part of the userspace core.

The GNU software foundation is the creator and current maintainer of the GPL license, and mostly uses that license for its software and is the main enforcer of its infringements.

##GNU alternatives

Some notable alternatives to the GNU tools:

#POSIX

LSB is already highly POSIX compliant, and it states that it is on of its long term goals meant to become fully POSIX compatible

Incompatibilities are being listed for future resolution.

There a few POSIX requirements that the Linux kernel explicitly does not implement because it considers them impossible to implement efficiently.

#LSB

##core

- CLI utilities. Very close to POSIX except that:

    - adds `lsb_release`

    The Desktop specification also adds `xdg-utils`.

- elf file type
- rpm is the default packaging format! The package format is not specified.
- users and groups
- system initialization
- libc: C standard libraries shared object
- libm: C math library shared object
- libncurses: for command line interfaces

##C++

- C standard library shared objects are required

##Interpreted languages

- Python
- Perl

##Desktop

- OpenGL shared objects
- X11, GTK+, Qt runtimes
- JPEG, PNG shared object libraries
- ALSA (sound)
- freedesktop.org XDG [Base Directory structure](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html), and [xdg-utils](http://portland.freedesktop.org/xdg-utils-1.0/).

#Basename conventions

Not in the FHS, but often used.

###^\.

Hidden files.

It is up to programs to decide how to treat them.

###\.~$

Backup file.

###\.bak$

Backup file.

###\.orig$

Original installation file.

###\.d$

Many theories, a plausible one: differentiate `a.conf file` from `a.conf.d` dir normally, all files in the `a.conf.d` dir will be sourced as if they are inside `a.conf`.

#FHS

The filesystem hierarchy standard specifies base directories for the system and what should go in them.

It is also maintained by the Linux foundation, and followed by the LSB.

[freedesktop.org basedir spec](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html)  is another an important directory standard that specifies directory structures on top of the FHS. It has been adopted by the recent LSB 4.1 under the desktop section: <http://refspecs.linux-foundation.org/LSB_4.1.0/LSB-Desktop-generic/LSB-Desktop-generic.html#XDG-BASEDIR>

##De facto but not mentioned in FHS

- `/etc/alternatives`

    Contains symlinks that determine default programs.

    For example: `editor -> /usr/bin/vim` and so on.

    Can be updated via `man update-alternatives`.

    Some important ones are:

    - editor: text editor
    - x-www-browser: text editor

#Distributions

A Linux distribution is a LSB compliant system.

Typically, distributions contain end user applications such as text editors of music players, making it usable out of the box for a large variety of non programmer users.

This work is left for third party enterprises of community projects such as Ubuntu or Fedora which are maintained by Canonical and Red Had enterprises respectively.

LSB is meant to contain all the core tools that allow compliant applications to be portable across any compliant distribution.

LSB does however specifies many more tools than POSIX and supports almost all base tools used by user friendly applications found in distributions.

##lsb_release

Command required by the LSB.

Get distro maintainer, name, version and version codename:

    lsb_release -a

Extract id programmatically to autodetect distro:

    distro="$(lsb_release -i | sed -r 's/.*:\t(.*)/\1/')"

#Sources

- `git clone http://git.kernel.org/pub/scm/docs/man-pages/man-pages`

    The Linux man pages, documenting the kernel and C interfaces to it.

    In special, look under

    - `Documentation/` for docs
    - `include/linux` for stuff you may use from modules

- info

    GNU project substitute for man.

    Usually much longer explanations and examples.

    Better node wise navigation.

- the geek stuff

   <http://www.thegeekstuff.com>

   Short tutorials with lots of examples.

- <http://www.linuxfromscratch.org/>

    Linux from scratch.

    Teaches how to build a minimal Linux distro from base standard packages.

- <https://wiki.archlinux.org/index.php/Installation_Guide>

    Arch Linux installation guide.

    Since Arch Linux is very minimalistic, installing it can teach you a lot.

    Like LFS but you start at a higher level already.

- <http://www.cavecanen.org/linux/humour/horrorstories.txt>

    Real *NIX sysadmin horror stories of things gone terribly wrong.

[lsb]: http://www.linuxfoundation.org/collaborate/workgroups/lsb/download
[linux foundation]: http://www.linuxfoundation.org/

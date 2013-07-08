linux in informal terms can be either a computer system that:

- a computer system which complies to the [linux standar base (lsb)](lsb)
    which is the main standard maintained by the [linux foundation][]

- uses the linux kernel. TODO is this specified by the lsb? where?

the lsb specifies the minimum intefaces every linux system must offer.

the central component of the linux operating system is the linux kernel,
released in 1991 by Linus Trovalds, however much of its core user space
software comes from the gnu project. For this reason linux systems
may also be called gnu/linux.

# sources

- `git clone http://git.kernel.org/pub/scm/docs/man-pages/man-pages`

    the linux man pages, documenting the kernel and C interfaces to it.

    in special, look under

    - `Documentation/` for docs
    - `include/linux` for stuff you may use from modules

# distributions

a linux distribution is a linux system which in addition has end user
applications such as text editors of music players.

this work is left for third party enterprises of community projects such as Ubuntu
or Fedora which are maintained by Canonical and Red Had enterprises respectively.

lsb is meant to contain all the core tools that allow compliant applications
to be portable across any compliant distribution.

lsb does however specifies many more tools than POSIX
and supports almost all base tools used by user friendly applications
found in distributions

## find your distro

get distro maintainer, name, version and version codename:

    lsb_release -a

lsb this standas for `linux standard base`

# certification

the linux foundation offers certification and compliance verification
tools for distribution developpers and application developpers.

the list of certified distributions and products can be found here:
https://www.linuxbase.org/lsb-cert/productdir.php?by_lsb.

notable certified systems include:

- Ubuntu 9.4

    However not later versions up to time of writting

    [It seems that](http://askubuntu.com/questions/89125/does-ubuntu-follow-the-linux-standard-base-lsb)
    Ubuntu does not intend to fully comply
    on certain specific points, but only be highly compliant

- Red Hat Enterprise Linux 6.0

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

# lsb and posix

lsb is already highly posix compliant, and it states that it is on of its
long term goals meant to become fully posix compatible

incompatibility are being listed for future resolution

there some posix requirements that the linux kernel simply does not

# fhs

the filesystem hierarchy standard specifies base directories
for the system and what should go in them

it is also maintained by the linux foundation, and followed by the lsb

# examples of what lsb specifies

## core

- elf filetype
- rpm is the default packaging format! The package is not specified
- users and groups
- system initialization
- libc: c standard libraries shared object
- libm: c math library shared object
- libncurses: for command line interfaces

## c++

- cstandard library shared objects are required

## interpreted languages

- python
- perl

## desktop

- opengl shared objects
- x11, gtk+
- jpeg, png shared object libraries
- alsa (sound)

# basename conventions

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

# signals

Signals are an ANSI C concept, with extensions by POSIX and Linux.

Aspects which are defined to ANSI C or POSIX shall not be convered here.

Get a list of all signals the system supports:

    kill -l

[lsb]: http://www.linuxfoundation.org/collaborate/workgroups/lsb/download
[linux foundation]: http://www.linuxfoundation.org/

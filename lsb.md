# LSB

<http://en.wikipedia.org/wiki/Linux_Standard_Base>

Standards: <http://refspecs.linuxfoundation.org/lsb.shtml>

Linux standard base.

Most official specification of what interfaces Linux systems should have.

Maintained by the Linux Foundation, of which it is the main standard

## core

-   CLI utilities. Very close to POSIX except that:

    - adds `lsb_release`

    The Desktop specification also adds `xdg-utils`.

-   elf file type

-   rpm is the default packaging format! The package format is not specified.

-   users and groups

-   system initialization

-   libc: C standard libraries shared object

-   libm: C math library shared object

-   libncurses: for command line interfaces

## C++

- C standard library shared objects are required

## Interpreted languages

- Python
- Perl

## Desktop

- OpenGL shared objects
- X11, GTK+, Qt runtimes
- JPEG, PNG shared object libraries
- ALSA (sound)
- freedesktop.org XDG [Base Directory structure](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html), and [xdg-utils](http://portland.freedesktop.org/xdg-utils-1.0/).

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

-   rpm is the default packaging format! The package format is not specified.

-   users and groups

-   system initialization

### elf file type

One spec for each architecture, each a very thin extensions of other well known specs like System V AMD64 ABI <http://www.x86-64.org/documentation/abi.pdf>

<http://refspecs.linuxbase.org/LSB_4.1.0/LSB-Core-generic/LSB-Core-generic/elf-generic.html>

### Libraries

The following libraries are required:

- `libc` ANSI C
- `libm` ANSI C
- `libgcc_s`
- `libdl`
- `librt` POSIX: `fork` and other process utilities
- `libcrypt`
- `libpam`
- `libncurses`
- `libz`

POSIX libraries are extended, and minimal requirements are set for non-POSIX ones: <http://refspecs.linuxbase.org/LSB_4.1.0/LSB-Core-generic/LSB-Core-generic/tocbaselib.html>

## Runtime languages

## Interpreted languages

- Python
- Perl

## Desktop

- OpenGL shared objects
- X11, GTK+, Qt runtimes
- JPEG, PNG shared object libraries
- ALSA (sound)
- freedesktop.org XDG [Base Directory structure](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html), and [xdg-utils](http://portland.freedesktop.org/xdg-utils-1.0/).

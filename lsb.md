# LSB

<http://en.wikipedia.org/wiki/Linux_Standard_Base>

Standards: <http://refspecs.linuxfoundation.org/lsb.shtml>

Linux standard base.

Most official specification of what interfaces Linux systems should have.

Maintained by the Linux Foundation, of which it is the main standard

The LSB is meant to contain all the core tools that allow compliant applications to be portable across any compliant distribution.

LSB does however specifies many more tools than POSIX and supports almost all base tools used by user friendly applications found in distributions.

The Linux foundation was separate from the LSB in the past, and used to be called: <https://en.wikipedia.org/wiki/Open_Source_Development_Labs>

## POSIX compliance

LSB is highly POSIX compliant, and it states that it is on of its long term goals meant to become fully POSIX compatible

Incompatibilities are being listed for future resolution.

There a few POSIX requirements that the Linux kernel explicitly does not implement because it considers them impossible to implement efficiently.

## Certification

The Linux foundation offers certification and compliance verification tools for distribution developers and application developers.

The list of certified distributions and products can be found here: <https://www.linuxbase.org/lsb-cert/productdir.php?by_lsb.>

Notable certified systems include:

-   Ubuntu 9.4

    However not later versions up to time of writing

    [It seems that](http://askubuntu.com/questions/89125/does-ubuntu-follow-the-linux-standard-base-lsb) Ubuntu does not intend to fully comply on certain specific points, but only be highly compliant.

-   Red Hat Enterprise Linux 6.0

## Components

### core

-   CLI utilities. Very close to POSIX except that:

    - adds `lsb_release`

    The Desktop specification also adds `xdg-utils`.

-   rpm is the default packaging format! The package format is not specified.

-   users and groups

-   system initialization

#### elf file type

One spec for each architecture, each a very thin extensions of other well known specs like System V AMD64 ABI <http://www.x86-64.org/documentation/abi.pdf>

<http://refspecs.linuxbase.org/LSB_4.1.0/LSB-Core-generic/LSB-Core-generic/elf-generic.html>

#### Libraries

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

### Runtime languages

### Interpreted languages

- Python
- Perl

### Desktop

- OpenGL shared objects
- X11, GTK+, Qt runtimes
- JPEG, PNG shared object libraries
- ALSA (sound)
- freedesktop.org XDG [Base Directory structure](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html), and [xdg-utils](http://portland.freedesktop.org/xdg-utils-1.0/).

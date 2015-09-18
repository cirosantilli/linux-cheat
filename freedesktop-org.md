# freedesktop.org

# XDG

AKA XDG because freedesktop.org was formerly known as the X Desktop Group, and the acronym "XDG" remains common in their work.

Large community website, de facto standard on certain areas, use its software and follow its standards if you can.

Generally followed by both GNOME and KDE for example.

Contains both standard specifications, and also hosts software projects.

<http://www.freedesktop.org/wiki/>

Hosts standard specifications and software projects.

Specifies:

-   autostart

-   `echo $XDG_CURRENT_DESKTOP`: current DE in use.

    Gnome 3 output: GNOME

## xdg-utils

XDG package of utilities.

<http://portland.freedesktop.org/xdg-utils-1.0/>.

A few useful applications that should be standard.

Adopted by the LSB 4.1.

## Base directory spec

<http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html>

Specifies where configuration and data files should be put, and environment variables that indicate that place such as `$XDG_CONFIG_HOME`

All environment variables have a default value to be assumed in case they are not present.

### XDG_CONFIG_HOME

Base location of per-user configuration files. Default value: `.config`.

### XDG_CONFIG_DIRS

Comma separated list of where to look for cross user configuration files.

Default value: `/etc/xdg`

### XDG_DATA_HOME

Data instead of configurations. Default: `.local`.

### XDG_DATA_DIRS

Data instead of configurations. Default: `/usr/local/share/:/usr/share/`.

### XDG_DATA_DIRS

### cache dir

### XDG_CACHE_HOME

<http://askubuntu.com/questions/102046/is-it-okay-to-delete-cache>

Temporary data. Default: `~/.cache`. Can get rather large, and since the standard says that "non-essential data files should be stored" there, it should be fine to delete it.

There is no global cache size option: you must configure cache limits for each individual application.

Note that some applications always build a cache before being used, e.g. `apt-file`.

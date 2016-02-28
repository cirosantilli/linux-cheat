# Autotools

1. [Hello world](hello-world/)

GNU's build system.

CMake is likely more portable. But if you ever touch a GNU project, better learn this.

KDE is a notable project that dumped it for CMake in KDE 4: <https://lwn.net/Articles/188693/>

## Build object files to custom directory

<http://stackoverflow.com/questions/1015700/autotools-library-and-object-file-output-control>

`cd` into the desired directory, and `../configure` from there.

## Compilation flags

Pass an extra one at `make` time:

- <http://stackoverflow.com/questions/7543978/how-to-pass-g3-flag-to-gcc-via-make-command-line>
- <http://stackoverflow.com/questions/3602927/add-compiler-option-without-editing-makefile>
- <http://stackoverflow.com/questions/1250608/passing-a-gcc-flag-through-makefile>

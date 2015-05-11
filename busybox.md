# BusyBox

Single executable that includes all POSIX command line utilities, including `sh`, and no libc dependency.

Popular for minimal distributions, e.g. <https://github.com/ivandavidov/minimal>

Source:

    git clone git://git.busybox.net/busybox

Once compiled, this generates a single `busybox` 2Mb executable, possibly with not external dependencies, often built with uClibc. E.g., if we do:

    ldd busybox

we get:



It is also possible to configure exactly which utilities will be present on the output.

You can use it either with subcommands:

    ./busybox echo a

or with symlinks, which is the standard approach when deploying it:

    ln -s busybox echo
    ./echo a

`busybox` uses `argv[0]` to decide the executable in this case.

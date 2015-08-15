# Debug

How to debug the Linux kernel.

## Preparation

First turn on the following options in `.config` and recompile:

    CONFIG_DEBUG_INFO=y
    CONFIG_GDB_SCRIPTS=y

`CONFIG_DEBUG_INFO` passes `-g` to GCC.

`CONFIG_GDB_SCRIPTS` attempts to load handy kernel scripts under `scripts/gdb`.

You then need to run:

    gdb [other options] vmlinux

or from inside GDB:

    file vmlinux

to load the debug symbols.

To enable the GDB scripts, you need to allow GDB to auto source the Python script at `build-dir/vmlinux-gdb.py`, e.g. with:

    add-auto-load-safe-path .

This Python file gets sourced because of the naming convention: <https://sourceware.org/gdb/onlinedocs/gdb/Python-Auto_002dloading.html>

## QEMU

QEMU debugging will not be covered here. See QEMU for more information. It is one of the best methods.

## /proc/kcore

Represents the running kernel memory in core file format!

Usage:

    gdb vmlinux /proc/kcore

<http://stackoverflow.com/questions/5416406/why-is-there-no-debug-symbols-in-my-vmlinux?answertab=votes#tab-top>

TODO check: Of course, this only gives multiple static views of the kernel like coredumps, you cannot for example break at a given function with it.

## kgdb

TODO

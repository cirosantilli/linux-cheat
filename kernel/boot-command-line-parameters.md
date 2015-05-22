# Boot command line parameters

The kernel command line arguments are parameters passed to the kernel by GRUB when it is started.

They allow to configure the kernel at boot time without recompiling it.

Documented at:

    man bootparam

Useless options on by default on Ubuntu 12.04 which you should really remove because they hide kernel state and potentially useful debug information, and only exist not to scare newbs:

- `quiet`: suppress kernel messages
- `splash`: shows nice and useless image while the kernel is booting. On by default on Ubuntu 12.04. Remove this useless option

## Get the command line arguments for the currently running kernel

    rat /proc/cmdline

## Where they are coded

On 4.0, they seem to be coded all over the kernel tree with the `__setup` macro. But there are many things which do not show on `man bootparam` which are there, so I'm not sure.

`kernel/params.c` also seems interesting.

## How exactly are those parameters passed to the booting kernel?

TODO

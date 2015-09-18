# Boot command line parameters

The kernel command line arguments are parameters passed to the kernel by GRUB when it is started.

We usually set them up in a GRUB configuration file, at boot time GRUB let's us modify them to configure the kernel at boot time without recompiling it, just like command line arguments of regular programs.

How to modify it with GRUB: <http://askubuntu.com/questions/19486/how-do-i-add-a-kernel-boot-parameter>

Documented at:

    man bootparam

And <https://www.kernel.org/doc/Documentation/kernel-parameters.txt>

TODO why are not all parameters documented there? E.g., where is `splash`?

Useless options on by default on Ubuntu 12.04 which you should really remove because they hide kernel state and potentially useful debug information, and only exist not to scare newbs:

- `quiet`: suppress kernel messages
- `splash`: shows nice and useless image while the kernel is booting. On by default on Ubuntu 12.04. Remove this useless option

## Get the command line arguments for the currently running kernel

<http://unix.stackexchange.com/questions/48601/how-to-display-kernel-command-line-parameters>

    cat /proc/cmdline

## Where they are coded

On 4.0, they seem to be coded all over the kernel tree with the `__setup` macro. But there are many things which do not show on `man bootparam` which are there, so I'm not sure.

`kernel/params.c` also seems interesting.

## How exactly are those parameters passed to the booting kernel?

TODO

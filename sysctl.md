# sysctl

# Kernel parameters

View and modify kernel parameters at runtime for a single session.

Also the name of a deprecated system call TODO in favor of what? Writing to `/proc/sys` files?

Documentation of all kernel parameters: <https://github.com/torvalds/linux/blob/master/Documentation/kernel-parameters.txt>

List all:

    sudo sysctl –a

TODO check Each entry of form:

    a.b.c

corresponds to a file under:

    /proc/sys/a/b/c

So you can also get its value with:

    cat /proc/sys/a/b/c

Set a value for the current session:

    sudo sysctl a.b.c=d

with `/proc/sys/` directly:

    echo d | sudo tee -a /proc/sys/a/b/c

## kernel

### core_pattern

See:

    man core

How core files are named:

    cat /proc/sys/kernel/core_pattern

If it starts with a pipe character `|`, this will call the given program to deal with the coredump. Ubuntu 14.04 for example has:

    |/usr/share/apport/apport %p %s %c %P

which passes the work to `apport`.

### randomize_va_space

Control ASLR.

<http://askubuntu.com/questions/318315/how-can-i-temporarily-disable-aslr-address-space-layout-randomization>

    echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
    echo 2 | sudo tee /proc/sys/kernel/randomize_va_space

## /etc/sysctl.conf

## /etc/sysctl.conf.d/

Configuration files to make settings permanent.

All files in the `.d` get sourced.

## hostname

The effective hostname.

Normally taken from `/etc/hostname` at startup.

## swappiness

<http://askubuntu.com/questions/103915/how-do-i-configure-swappiness>

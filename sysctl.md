# sysctl

# Kernel parameters

View and modify kernel parameters at runtime for a single session.

Also the name of a deprecated system call TODO in favor of what? writing to `/proc/sys` files?

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

Set it permanently:

    echo d | sudo tee -a /proc/sys/a/b/c

## /etc/sysctl.conf

Configuration file to make settings permanent.

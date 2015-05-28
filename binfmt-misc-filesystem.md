# binfmt_misc filesystem

<https://www.kernel.org/doc/Documentation/binfmt_misc.txt>

Allows creating a new custom `binfmt` from userspace: <https://www.kernel.org/doc/Documentation/binfmt_misc.txt> to be used with the `execve` system call like any other.

The corresponding file on the kernel is `fs/binfmt_misc.c`. There is one such file for each executable format, e.g. `fs/binfmt_elf`.

Default mount point:

    binfmt_misc /proc/sys/fs/binfmt_misc

done by default on Ubuntu 14.04.

Show currently registered formats:

    ls binfmt_misc /proc/sys/fs/binfmt_misc

Ubuntu 14.04 contains:

    python2.7
    jar

which allows you to execute `.pyc` and `.jar` files directly! Awesome!

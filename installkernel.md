# installkernel

Install give kernel to system.

Called by `make install` on Linux 4.0.

On Ubuntu 14.04, furnished by the `debianutils` package.

It does a:

    /run-parts /etc/kernel/postinst.d

which runs all scripts under `/etc/kernel/postinst.d`. Files in that directory are furnished by several packages.

In particular, this also runs `update-grub` via `/etc/kernel/postinst.d/zz-update-grub`.

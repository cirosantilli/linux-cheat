# chroot

Execute single command with new root.

If that command happens to be a `/bin/bash`, then you can execute other ones

The root of a process is a Linux concept: every process descriptor has a root field, and system calls issued from that process only look from under the root (known as `/` to that process).

Applications:

- lightweight virtualization. TODO downsides over other methods?
- modifying a filesystem that is not your main one. Typical example: you blew up your OS installation, the you pop in a live disk, and try to fix it. The simple

## Example

You have a partition that contains a Linux system, but for some reason you are unable to run it.

On Ubuntu, one easy way to generate such partition to play with is with the `debootstrap` command

    sudo debootstrap --verbose trusty /tmp/debootstrap http://archive.ubuntu.com/ubuntu

Then:

    sudo chroot /tmp/debootstrap

## i

Remove all existing environment variables, and only use the given ones:

    sudo chroot /media/other_linux /bin/env -i \
        HOME=/root \
        TERM="$TERM" \
        PS1='\u:\w\$ ' \
        PATH=/bin:/usr/bin:/sbin:/usr/sbin \
        /bin/bash --login

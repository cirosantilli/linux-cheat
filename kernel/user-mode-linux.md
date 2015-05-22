# User-mode Linux

# UML

Good lightweight virtualization.

TODO check Major downside: the root filesystem has to have user mode features?

Good tutorial: <https://web.archive.org/web/20110311190407/http://kuparinen.org/martti/comp/ubuntu/en/uml.html>

<https://en.wikipedia.org/wiki/User-mode_Linux>

Run Linux as a user process inside a Linux.

Before was a fork, later merged in 2.6 as a new architecture under `arch/um`.

<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/virtual/uml/UserModeLinux-HOWTO.txt?id=refs/tags/v4.0> TODO: does it need the patch mentioned there or not?

<http://askubuntu.com/questions/33958/how-to-correctly-start-a-ubuntu-user-mode-linux-from-the-command-line>

Quickstart tested on Kernel 4.0 source on a 3.13 host: TODO get working.

    make mrproper
    make defconfig ARCH=um
    make ARCH=um
    ./kernel32-2.6.37.5 ubda=Ubuntu-MaverickMeerkat-i386-root_fs mem=256m root=/dev/ubda init=/bin/bash

# Execute single command with new root.

# The root of a process is a Linux concept: every process descriptor has a root field,
# and system calls issued from that process only look from under the root (known as `/` to that process).

## application

  # You have a partition that contains a linux system,
  # but for some reason you are unable to run it.

  # You can use that partition with bash by using chroot into it,
  # and you might then try to fix it from there.

  # Example:

    sudo chroot /media/other_linux/

  # More advanced example, if you want to start from a completelly clean bash environment:

    sudo chroot /media/other_linux /bin/env -i \
        HOME=/root         \
        TERM="$TERM"        \
        PS1='\u:\w\$ '       \
        PATH=/bin:/usr/bin:/sbin:/usr/sbin \
        /bin/bash --login

  # This will in addition clear enviroment variables, and read login scripts found on the chroot.


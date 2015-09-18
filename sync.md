# sync

Coreutils.

Ensure that all data is written to disk.

    sudo dd if=my.img of=/dev/sdX
    sync

Note that not even `close()` ensures it: a `fsync()` system callis needed: <http://stackoverflow.com/questions/705454/does-linux-guarantee-the-contents-of-a-file-is-flushed-to-disc-after-close>

TODO how does this utility work? What system call does it use exactly on what files / devices?

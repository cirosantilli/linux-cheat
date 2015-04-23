# mknod

coreutils <https://www.gnu.org/software/coreutils/manual/html_node/mknod-invocation.html#mknod-invocation >

Create character, block or FIFO (named pipe) files.

`mkfifo` can also create FIFOs and is POSIX.

Create a char file with major number 1 and minor number 9:

    sudo mknod -m 666 /tmp/myurandom1 c 1 9
    sudo mknod -m 666 /tmp/myurandom2 c 1 9

Since those are the specifications for `urandom` as shown by `stat /dev/urandom`, we have created a new entry point for `urandom`:

    head -c10 /tmp/myurandom1 | od
    head -c10 /dev/myurandom2 | od

# dev filesystem

Contains device driver files.

To really understand what is going on, learn how to make a minimal device driver yourself. This is not documented here.

Standard device number and paths are documented at: <http://www.lanana.org/docs/device-list/devices-2.6+.txt>, which is part of the LSB.

Some devices are created automatically by the Kernel even if there is no corresponding hardware to offer services under read write, e.g. random number generation.

## devtmpfs

Like `proc` and `sysfs`, the `dev` filesystem is a virtual filesystem that can be mounted any number of times:

    mkdir newdev
    sudo mount -t devtmpfs none newdev

The actual filesystem name is `devtmpfs`, and `/dev` is just the usual mount point.

Most distributions also mount `devpts` inside `/dev` in addition to `devtmpfs`:

## null

## /dev/null

    man null

Type, major, minor: character, 1, 3

Discards whatever input is given to it by a `write` syscall.

Very useful to discard undesired stdout / stderr:

    echo a > /dev/null

Generates no output.

## zero

## /dev/zero

    man zero

Major, minor: 1, 5

Returns as many zeros as asked for by a read syscall.

You cannot `cat` this because cat reads until the file is over, but this special file is *never* over.

Application: reset entire partitions to 0.

Example:

    dd if=/dev/zero count=1 status=none | od -Ax -tx1

Output:

    000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    *
    000200

Meaning if you don't speak `od` language (now is a good time to learn): 512 bytes with value 0.

## full

## /dev/full

    man full

If you write to it, the `write` always returns `ENOSPC` error.

Example:

    echo a > /dev/full

If you read from it, returns as many null chars as were asked for by read, like `/dev/zero`.

## Pseudorandom number generators

The kernel implements a random number generator which draws entropy from non-predictable events, typically device events such as mice movements or disk reads for example.

Just like for `/dev/zero`, it is useless to cat those files, since they don't have and end, and `cat` tries to read to the end of the file before printing.

### random

### /dev/random

    man random

Major, minor: 1, 8

`/dev/random` returns random numbers one by one whenever enough entropy is generated. It is slower than `urandom`, but has greater entropy.

x86 considered using the `RDRAND` instruction introduced in 2011 as part of the entropy pool, but this has generated some controversy as it would rely on a process which is not observable and could lead to cryptographic back-doors.

### urandom

### /dev/urandom

    man urandom

Major, minor: 1, 9

`/dev/urandom` returns random numbers continuously. It is faster than `random`, but has less entropy. It should however be good enough for most applications.

Example: get 16 random bytes:

    dd bs=16 if=/dev/urandom count=1 status=none | od -Ax -tx1
    dd bs=16 if=/dev/urandom count=1 status=none | od -Ax -tx1

Sample output:

    000000 51 e6 4d 6d 98 5f 3e 48 c9 9a 04 6f d7 f2 57 c6
    000010

    000000 7d 87 2c a3 32 9d d0 78 18 9d 5f ab c5 7a d2 ea
    000010

Since the 16 bytes are random, the lines are extremely likely to be different.

## /dev/tty

The current terminal. Also works on xterm windows.

Try:

    echo a >/dev/tty

`a` appears on the terminal screen even if stdout was redirected somewhere else, because `a` was sent directly to the tty.

Application: show some output that is also going to be redirected. E.g.:

    echo a | tee /dev/tty | grep a

This both forwards the pipe, and prints it to the terminal.

See also: `/proc/self/fd/[0-2]`

## /dev/console

Similar to `tty`, but may only work on actual ttys such as Ubuntu Ctrl + Alt + F2, and not on xterm windows.

Discussion: <http://unix.stackexchange.com/questions/60641/linux-difference-between-dev-console-dev-tty-and-dev-tty0>

## sda

## /dev/sda

Device files of this type represent block devices such as hard disks or flash memory.

The first device is `sda`, the second `sdb`, and so on.

Also, partitions inside those devices have device files for them too.

The first primary partition inside `sda` will be called `sda1`, the second main partition `sda2`, and so on.

Logical partitions are numbered from `sda5` onwards.

*Warning*: usage of block devices can be very dangerous and lead to data loss!

Example: copy a block device on `/dev/sda/` to the one one `/dev/dsb`:

    #sudo dd bs=4M if=/dev/zero of=/dev/sdb

This could be used to make a full system backup.

Example: write pseudorandom sequences into `/dev/sda/` to hide data:

    #sudo dd bs=4M if=/dev/urandom of=/dev/sda

## /dev/input/mice

You can have some fun with mouses. Search for the mice or mouse device files and cat them:

    sudo cat /dev/input/mice

And then:

    sudo cat /dev/input/mouse0

Now note that when you move the mouse, cat spits something out to the screen!

`mice` is the combination of all mice, and each other `mouseX` is a single mouse device.

## loop

## loop0

## loop1

TODO

Type, major, minor: block, 7, `X` for `loopX`

Used to mount regular files that contain filesystems instead of device files as is usual.

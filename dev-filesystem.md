# dev filesystem

Contains device driver files, and things related to device drivers like symlinks that give nice names to device drives.

Files are documented under `man 4`.

To understand what is going on, make a minimal device driver yourself. This is not documented here. Prerequisites you will learn when you do that:

- what do the type, major and minor numbers mean
- you can device arbitrary effects to standard file system calls like `open` and `close` on device files. They are usually not represented on disk in any way.

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

Type, major, minor: block, 8, X, one per partition:

    brw-rw---- 1 root disk 8, 0 Aug 23 03:45 /dev/sda
    brw-rw---- 1 root disk 8, 1 Aug 23 04:43 /dev/sda1
    brw-rw---- 1 root disk 8, 2 Aug 23 03:45 /dev/sda2
    brw-rw---- 1 root disk 8, 3 Aug 23 03:45 /dev/sda3
    brw-rw---- 1 root disk 8, 4 Aug 23 03:45 /dev/sda4
    brw-rw---- 1 root disk 8, 5 Aug 23 03:45 /dev/sda5
    brw-rw---- 1 root disk 8, 6 Aug 23 03:45 /dev/sda6
    brw-rw---- 1 root disk 8, 7 Aug 23 03:45 /dev/sda7
    brw-rw---- 1 root disk 8, 8 Aug 23 03:45 /dev/sda8

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

    sudo hd /dev/input/mice

And then:

    sudo hd /dev/input/mouse0

Now note that when you move the mouse, cat spits something out to the screen!

`mice` is the combination of all mice, and each other `mouseX` is a single mouse device.

This subsystem is called `evdev`: <https://en.wikipedia.org/wiki/Evdev>

## /dev/shm

Files created by `shm_open` calls. This function is part of POSIX, but creation of the files under `/dev` is not.

## /dev/disk

Symlinks to partition identifiers.

Allows you to get identifier info.

If id no present, link not there.

TODO what is the name of the subsystem that implements this? Where is it documented?

Example:

    ls -l /dev/disk/

Sample output:

    total 0
    drwxr-xr-x 2 root root 420 Aug 23  2015 by-id
    drwxr-xr-x 2 root root 100 Aug 23  2015 by-label
    drwxr-xr-x 2 root root 180 Aug 23  2015 by-uuid

Then:

    ls -l /dev/disk/by-id/

Sample output:

    total 0
    lrwxrwxrwx 1 root root 10 Aug 23 03:45 322246df-fed3-42f7-ba4d-4d72d6cce95f -> ../../sda5
    lrwxrwxrwx 1 root root 10 Aug 23 03:45 5CE89967E8994066 -> ../../sda3
    lrwxrwxrwx 1 root root 10 Aug 23 03:45 84f8087d-fc74-45b8-a6a2-180856b48982 -> ../../sda6
    lrwxrwxrwx 1 root root 10 Aug 23 04:43 A6DA9BF3DA9BBE4D -> ../../sda1
    lrwxrwxrwx 1 root root 10 Aug 23 03:45 D0EC9F59EC9F38A4 -> ../../sda2
    lrwxrwxrwx 1 root root 10 Aug 23 03:45 e45497f8-6295-41da-ad8c-90dbbac264e8 -> ../../sda8
    lrwxrwxrwx 1 root root 10 Aug 23 03:45 ff1b6e50-82ff-4696-823f-774b0f803298 -> ../../sda7

## /dev/stdin

## /dev/stdout

## /dev/stderr

Symlinks to `/proc/self/fd/{0,2}`.

No portability: <http://unix.stackexchange.com/questions/36403/portability-of-dev-stdouit>

Bash also implements it as a built-in magic path.

Useful when annoying programs don't follow the usual convention of `-` for stdout / stdin in the place of files, e.g.: <http://www.serverfault.com/questions/329150/is-there-a-way-to-make-objdump-read-from-stdin-instead-of-file>

But it does not work all the time, since those programs may not implement `-` because they rely on `seek` calls which are not supported on pipes.

## /dev/rtc

    man rtc

Real time clock.

TODO example.

## /dev/mem

    man mem

Allows you to read physical memory.

## fbdev

## /dev/fb0

## Framebuffer

TODO: minimal example.

TODO what is it exactly?

I think this can be used to dump and write to the screen.

Used by `fbi` to show images to screen, also used by X I guess?

Looks like the X-server is implemented through it!

- <https://www.kernel.org/doc/Documentation/fb/api.txt>
- <https://www.kernel.org/doc/Documentation/fb/framebuffer.txt>
- <http://stackoverflow.com/questions/4996777/paint-pixels-to-screen-via-linux-framebuffer>
- <http://superuser.com/questions/495948/can-i-display-a-jpg-or-png-to-the-framebuffer-dev-fb>
- <http://unix.stackexchange.com/questions/25063/capturing-area-of-the-screen-without-a-desktop-environment>
- <http://serverfault.com/questions/125524/linux-cli-screenshot-without-x>
- `man fbdev`

### /dev/dri

### DRM

### Direct Rendering Manager

<https://en.wikipedia.org/wiki/Direct_Rendering_Manager>

TODO: minimal example.

Supersedes fbdev.

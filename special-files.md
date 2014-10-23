The kernel communicates parameters to user space using special files, located mainly under `/proc/`, `/sys/` and `/dev/`.

Those files are not stored in permanent storage like HDs, only in RAM. They can still be accessed via open, read and write system calls, therefore they can be manipulated from sh via `cat` and redirection.

What the file IO system calls do exactly when operating on special files depends on what the `file_operations` `struct` associated to the file was programmed to do. Kernel modules can create devices which do any arbitrary operation.

Certain utilities are implemented on Linux not via system calls, but by interpreting `proc` information of specific files. For example, `ps` finds process information through the `proc` filesystem. One can therefore rely on those interfaces ( which files outputs information in which format).

TODO why is it advantages to use special files instead of system calls? Is it useful mostly to handle information for which the output size is unknown, by reusing file IO operations?

#proc filesystem

Offer access system information of user processes.

Files documented at:

    man proc

Some interesting files include:

-   numeric directories: `/proc/1/`, `/proc/2/`, ...:

    Contain standard directory structures with process info.

    This is why that dir is called `/proc`

-   `cat /proc/cpuinfo`: information on CPU

-   `cat /proc/meminfo`: information on RAM memory

-   `cat /proc/modules`: information on modules

-   `cat /proc/mounts`: list all mounted filesystems and some info on them

-   `cat /proc/partitions`: `softirq` info

-   `cat /proc/sched_debug`: scheduler info for debugging

-   `cat /proc/slabinfo`: slab allocator info

-   `cat /proc/softirqs`: `softirq` info

-   `cat /proc/version`: Linux kernel version and other system info. Similar to `uname -a` output.

-   `cat /proc/devices`: information on registered character and block devices.

    Does not consider files under `/dev/`, but registrations done for example via `alloc_chrdev_region`.

    Sample lines:

        Character devices:
        1 mem
        4 tty

    Which say that:

    - major number 1 is taken device named `mem`
    - major number 4 is taken device named `tty`

    where the device name is what was passed to the `alloc_chrdev_region` call.

-   `sudo cat /proc/kallsyms | less`: list of kernel symbols

    Sample output lines:

        c10010c0 t do_signal
        c1001980 T do_notify_resume
        ^        ^ ^
        1        2 3

    Fields:

    1. address
    2. type. Same as used by the `nm` utility.
    3. id

##/proc/uptime

How long the system has been up for.

Used by the procps `uptime` utility.

Sample output:

    6729.78 23034.43

##/proc/loadavg

##Load average

    cat /proc/loadavg

What percentage of the CPU time was used.

Sample output:

    0.25 0.20 0.23 1/699 10903
    ^    ^    ^    ^     ^
    1    2    3    4     5

Meaning:

-   1, 2, and 3: load average over the last 1, 5 and 15 minutes.

    Sample values:

    - `1.0` all CPU time was used exactly.
    - `2.0` it would require 2 CPUs to handle the load. The wait queue got longer.

    This number does not consider how many CPU cores you have.
    E.g., if you have 4 cores, then you can handle a load average of `4.0`.

    A good rule of thumb is: keep it below `0.7`.
    If it goes over, start investigating before things start break.

-   4: TODO

-   5: PID of the last process created on the system.

Used by tools such as `top`, `uptime`.

#dev filesystem

Represent devices, either physical or virtual.

Many virtual devices are created automatically by the Kernel to offer
certain file like operations, such as random number generation.

Device drivers are kernel modules created by hardware vendors that implement
a dev file that allows access to a device.

Several virtual dev files are documented directly under their basename,
e.g.: `/dev/null` is documented at:

    man null

##/dev/sda

Device files of this type represent block devices such as hard disks or flash memory.

The first device is `sda`, the second `sdb`, and so on.

Also, partitions inside those devices have device files for them too.

The first primary partition inside `sda` will be called `sda1`,
the second main partition `sda2`, and so on.

Logical partitions are numbered from `sda5` onwards.

*Warning*: usage of block devices can be very dangerous and lead to data loss!

Example: copy a block device on `/dev/sda/` to the one one `/dev/dsb`:

    #sudo dd bs=4M if=/dev/zero of=/dev/sdb

This could be used to make a full system backup.

Example: write pseudorandom sequences into `/dev/sda/` to hide data:

    #sudo dd bs=4M if=/dev/urandom of=/dev/sda

##/dev/null

    man null

Discards whatever input is given to it by a `write` syscall.

Very useful to discard undesired stdout / stderr:

    echo a > /dev/null

Generates no output.

##/dev/zero

    man zero

Returns as many zeros as asked for by a read syscall.

You cannot `cat` this because cat reads until the file is over,
but this special file is *never* over.

Application: reset entire partitions to 0.

Example:

    dd if=/dev/zero count=1 status=none | od -Ax -tx1

Output:

    000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    *
    000200

Meaning if you don't speak `od` language (now is a good time to learn): 512 bytes with value 0.

##/dev/full

    man full

If you write to it, the `write` always returns `ENOSPC` error.

Example:

    echo a > /dev/full

If you read from it, returns as many null chars as were asked for by read, like `/dev/zero`.

##Pseudorandom number generators

The kernel implements a random number generator which draws entropy from
non-predictable events, typically device events such as mice movements or disk reads for example.

Just like for `/dev/zero`, it is useless to cat those files, since they don't have and end,
and `cat` tries to read to the end of the file before printing.

###/dev/random

    man random

`/dev/random` returns random numbers one by one whenever enough entropy is generated.
It is slower than `urandom`, but has greater entropy.

###/dev/urandom

Documented at:

    man urandom

`/dev/urandom` returns random numbers continuously. It is faster than `random`,
but has less entropy. It should however be good enough for most applications.

Example: get 16 random bytes:

    dd bs=16 if=/dev/urandom count=1 status=none | od -Ax -tx1
    dd bs=16 if=/dev/urandom count=1 status=none | od -Ax -tx1

Sample output:

    000000 51 e6 4d 6d 98 5f 3e 48 c9 9a 04 6f d7 f2 57 c6
    000010

    000000 7d 87 2c a3 32 9d d0 78 18 9d 5f ab c5 7a d2 ea
    000010

Since the 16 bytes are random, the lines are extremely likely to be different.

##/dev/tty

The current terminal. Also works on xterm windows.

Try:

    echo 'echo a >/dev/tty' > s
    bash s >/dev/null

`a` appears on the terminal screen even if stdout was redirected to `/dev/null`, because `a` was sent directly to the tty.

##/dev/console

Similar to `tty`, but may only work on actual ttys such as Ubuntu Ctrl + Alt + F2, and not on xterm windows.

Discussion: <http://unix.stackexchange.com/questions/60641/linux-difference-between-dev-console-dev-tty-and-dev-tty0>

##/dev/input/mice

You can have some fun with mouses. Search for the mice or mouse device files and cat them:

	sudo cat /dev/input/mice

And then:

	sudo cat /dev/input/mouse0

Now note that when you move the mouse, cat spits something out to the screen!

`mice` is the combination of all mice, and each other `mouseX` is a single mouse device.

#sys filesystem

TODO

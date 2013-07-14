there are things which are hard to do from regular user programs such as
directly talking to hardware

some operations can be done via system calls, but if you want flexibility and
speed, using the kernel ring is fundamental

however:

- it would be very complicated to recompile the kernel and reboot every time you make some modification
- the kernel would be huge if it were to support all possible hardware

modules overcome those two problems exactly because they can be loaded into the kernel
*while it is running* and use symbols that the kernel chooses to export TODO which

it then runs in the same address space as the kernel and with the same permissions
as the kernel (basically do anything)

compiled modules are special object files that have a `.ko` extension instead of `.o`
they also contain module specific metadata

device drivers (programs that enables the computer to talk to hardware)
are one specific type of kernel modules

two devices can map to the same hardware!

#config files

if file it gets read, if dir, all files in dir get read:

    sudo ls /etc/modprobe.d
    sudo ls /etc/modprobe.conf

modules loaded at boot:

    sudo cat /etc/modules

#module-init-tools

##package version

from any of the commands, --version

    modinfo --version

package that provides utilities

##lsmod

list loaded kernel modules

info is taken from `/proc/modules`

    lsmod

sample output:

    cfg80211              175574  2 rtlwifi,mac80211
    ^^^^^^^^              ^^^^^^  ^ ^^^^^^^,^^^^^^^^
    1                     2       3 4       5

1. name
2. size
3. numer of running instances.

	If negative, TODO

4. depends on 1
5. depends on 2

to get more info:

    cat /proc/modules

also contains two more columns:

- status: Live, Loading or Unloading
- memory offset: 0x129b0000

##modinfo

get info about a module by filename or by module name:

    modinfo ./a.ko
    modinfo a

##insmod

loads the module

does not check for dependencies

    sudo insmod

##modprobe

list available modules relative path to `/lib/modules/VERSION/`:

    sudo modprobe -l

load the module:

    sudo modprobe $m

checks for dependencies

load module under different name to avoid conflicts:

    sudo modprobe vmhgfs -o vm_hgfs

remove module

    sudo modprobe -r $m

check if dependencies are ok:

    sudo depmod -a

get info about given `.ko` module file:

    m=a
    sudo rmmod $m

#includes

the default Makefile which is called by the Makefile in this directory automatically
adds `/usr/src/linux-headers-$(CUR_KERNEL_VERSION)/` TODO check

those come directly from the kernel source tree.

#device drivers

Devices map to filesystem under `/dev/`. You can get info on them with:

    ls -l /dev

Those files are not on disk files, but offer an interface similar to disk files
via the same system calls.

On this case however, it is entirely up to the device writer to specify what each call
should do. Obviously, developers should use intuitive calls for the operations,
so for exapmle `open` should make any required initializations, `write` send data to the device,
`read` get data from the device, and `close` make cleanup operations.

There are three main types of devices:

- block and char

    crw-rw----  1 root tty       7,   1 Feb 25 09:29 vcs1
    brw-rw----  1 root disk      8,   0 Feb 25 09:30 sda
    ^
    type

- b: block
- c: char

The `b` here is my hd.

Each partition also gets a b file

##major and minor numbers

using `ls -l`:

    crw-rw----  1 root tty       7,   1 Feb 25 09:29 vcs1
                                 ^    ^
                                 1    2

- 1: major number.

	traditionally tells kernel which driver controls the device represented by this file

	currentlly many drivers can share a single major number.

- 2: minor number.

	id of each hardware controlled by a given driver.

Get a list of all major numbers attributed and the name of the related device:

	cat /proc/devices

Both are stored inside a `dev_t` type (a single int, with some bytes for each number).
You can manipulate dev_t with the macros:

- `MAJOR(dev_t dev)`: get major number of a `dev_t`
- `MINOR(dev_t dev)`: get major number of a `dev_t`
- `MKDEV(int major, int minor)`: make `dev_t` from major and minor

---

To register the char use:

	int alloc_chrdev_region(dev_t *dev, unsigned int firstminor, unsigned int count, char *name);

where:

- `dev` is an output containing the device number dynamically allocated to your driver
- `firstminor` is the first minor number associated with the char driver
- `count` is the number of minor number which should be allocated.
- `name` is what will appear under `/proc/devices` and on the sysfs under TODO

You could fix the major device number yourself, but this is more and more deprecated.
This was done with the `register_chrdev_region` function.

##mknod

make a char file, major number 12, minor number 2:

    sudo mknod /dev/coffee c 12 2

##device files

###/dev/sda

Device files of this type represent block devices such as hard disks or flash memory.

The first device is `sda`, the second `sdb`, and so on.

Also, partitions inside those devices have device files for them too.

The first primary partion inside `sda` will be called `sda1`,
the second main partition `sda2`, and so on.

Logical partitions are numbered from `sda5` onwards.

*Warning*: usage of block devices can be very dangerous and lead to data loss!

Example: copy a block device on `/dev/sda/` to the one one `/dev/dsb`:

    #sudo dd bs=4M if=/dev/zero of=/dev/sdb

this could be used to make a full system backup.

Example: write pseudorandom sequences into `/dev/sda/` to hide data:

    #sudo dd bs=4M if=/dev/urandom of=/dev/sda

###/dev/null

Discards whatever input is given to it by a `write` sycall

Very useful to discard undesired stdout / stderr:

    echo a > /dev/null

Generates no output.

###/dev/zero

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

Meaning if you don't speak `od` language (now is a good time to learn):
512 bytes with value 0.

###/dev/full

if you write to it, the write returns ENOSPC error

Example:

    echo a > /dev/full

If you read from it, returns as many null chars as were asked for by read, like `/dev/zero`.

###pseudorandom number generators

The kernel implements a random number generator which draws entropy from
non predictable events, typically device events such as mice movements
or disk reads for example.

Just like for `/dev/zero`, it is useless to cat those files,
since they don't have and end, and `cat` tries to read to the end of the file before printing.

####/dev/random

`/dev/random` returns random numbers one by one whenever enough entropy
is generated. It is slower than `urandom`, but has greater entropy.

####/dev/urandom

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

Since the 16 bytes are random, the lines are extremelly likelly to be different.

###mice

you can have some fun with mouses. Search for the mice or mouse device files and cat them:

	sudo cat /dev/input/mice

and then:

	sudo cat /dev/input/mouse0

now note that when you move the mouse, cat spits something out to the screen!

`mice` is the combination of all mice, and each other `mouseX` is a single mouse device.

##system calls that use the char file

since the char file is not a real file but a representation of some hardware,
you have furnish methods used by system calls that deal with files
so those system calls can know what to do with that special file.

all of those operations are defined under `fs.h`

#hardware communication

talking to hardware always comes down to writting bytes in specific registers
at a given memory addres

some processors implement a single address space for memory and other hardware devices,
and others do not.

however, since x86 is the most popular and it separates addres spaces,
every architecture must at least mimic this separation.

on x86, the following specialized instructions exist for port io:

- IN            Read from a port
- OUT           Write to a port
- INS/INSB      Input string from port/Input byte string from port
- INS/INSW      Input string from port/Input word string from port
- INS/INSD      Input string from port/Input doubleword string from port
- OUTS/OUTSB    Output string to port/Output byte string to port
- OUTS/OUTSW    Output string to port/Output word string to port
- OUTS/OUTSD    Output string to port/Output doubleword string to port

however, you should avoid using those instructions directly in your device driver
code since linux functions abstract over multiple architectures (when possible)
making your code more portable.

those instructions cannot be used from an user space program since the kernel
prevents those from accessing hardware directly.

the memory space for non-memory locations is called I/O ports or I/O space.

to use a port, you must first reserve it. To see who reserved what:

	sudo cat /proc/ioports

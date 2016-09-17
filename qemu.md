# QEMU

First learn that emulation and virtualization are different: <http://stackoverflow.com/questions/6044978/full-emulation-vs-full-virtualization>

QEMU is originally an emulator. However a kernel module for it was created that allows it to use KVM virtualization with the `-enable-kvm` flag, which is much faster.

QEMU is used a lot in the context of Linux kernel development. Understanding all it's options is a great way to learn Linux kernel packaging.

The top 3 contributors are Red Hat employees.

<http://qemu.org>

<https://en.wikipedia.org/wiki/QEMU>

<https://github.com/qemu/qemu>

By default this talks about QEMU 2.0.0.

## User vs system modes

There are two main modes for QEMU operation: user or system.

System mode emulates the entire hardware, and requires you to use an OS with it. It is what we are usually most interested in.

System mode executables are named as `qemu-system-ARCH`.

User mode emulation just makes the CPU look like a new one, but reuses the currently running OS. Executable names are of form `qemu-ARCH`.

## Kernel without image

The simplest way to run a Linux kernel from source in QEMU is to give it:

- the kernel you compiled
- the root filesystem in which you will login

If you don't need permanent storage, use:

    qemu-system-i386 -kernel bzImage -initrd initrd.cpio.gz

where:

- `bzImage` is an output of the kernel build at `arch/x86/boot/bzImage` in v4.0
- `initrd.cpio.gz` is an `initrd` like can be generated with Minimal Linux Live: basically a cpio inside a `.gz` which contains the root filesystem without the kernel

## ISO

### Minimal Linux Live

<https://github.com/ivandavidov/minimal>

It is so minimal, that you don't even need KVM for it to work well.

Already contains `qemu` run scripts on the source, which does:

    qemu-system-x86_64 -cdrom minimal_linux_live.iso

`file` says it is an x86 boot sector.

### cdrom

TODO is there a difference between:

    qemu-system-x86_64        minimal_linux_live.iso
    qemu-system-x86_64 -cdrom minimal_linux_live.iso

### Ubuntu ISO

Download an ISO like <http://releases.ubuntu.com/14.04/ubuntu-14.04.2-desktop-amd64.iso> and:

    qemu-system-x86_64 -boot d -cdrom ./ubuntu-14.04.2-desktop-amd64.iso -m 512 -enable-kvm

If you don't pass `-enable-kvm`, it will be *really* slow:

- <http://unix.stackexchange.com/questions/108122/installing-ubuntu-13-0-desktop-in-qemu>
- <http://askubuntu.com/questions/419958/why-am-i-getting-a-black-screen-when-booting-vm-using-qemu>

Even so, it is still slower than VirtualBox.

There were some graphics artifacts, so it is was not really usable. But did seem to work.

`file ./ubuntu-14.04.2-desktop-amd64` says that it is an x86 boot sector.

### qemu-make-debian-root

Generate the image to a `trusty.img` file with:

    sudo qemu-make-debian-root 1024 trusty http://archive.ubuntu.com/ubuntu trusty.img
    sudo chown $USER:$USER trusty.img

TODO how to run this image? Man says it needs the kernel explicitly. The following panics:

    qemu-system-x86_64 -kernel bzImage trusty.img

Requires sudo because this must mount a device on the file.

`trusty` and `http://archive.ubuntu.com/ubuntu` are forwarded to `debootstrap`.

## Run QEMU in the terminal

Normally, QEMU opens up an X window.

But that is wasteful if you don't have a GUI in the system you are booting.

    qemu-system-x86_64 -kernel bzImage -initrd rootfs.cpio.gz -nographic -append 'console=ttyS0'

Doing `shutdown` there will only affect the host as usual.

How to access the QEMU monitor there (Ctrl + Alt + 1/2 on GUI): <http://stackoverflow.com/questions/14165158/how-to-switch-to-qemu-monitor-console-when-running-with-curses>

## Increase screen size

TODO

## hda

## Persistent storage

The `-hdX` options emulate attaching hard disks to the computer.

Those hard disks are file backed.

Example:

    F=a.ex2
    dd if=/dev/zero of="$F" bs=1024 count=64
    echo y | mke2fs -t ext2 "$F"
    qemu-system-x86_64 -boot d -cdrom minimal_linux_live.iso -hda a.ex2

Now from inside the emulator we can do:

    mkdir d
    mount /dev/sda d
    echo a > d/f
    poweroff

If you pass `-hdb` instead of `-hda`, the device will still be `/dev/sda` because it is the first one to be found (if you haven't passed `-hda` as well).

Now if we restart the emulator and do:

    mkdir d
    mount /dev/sda d
    cat d/f

We get:

    a

We could also verify that the backing file has been modified by mounting it to a loop device.

### Boot from the current system

**Don't do this**:

    #sudo qemu-system-x86_64 -m 512 -enable-kvm -hda /dev/sda

The emulation works at first, but then breaks your system because of file usage conflicts.

TODO: how to fix it afterwards?

### qemu-img

### qcow2

While `dd` + `mke2fs` is a simple and standard way to generate an image, it is not very versatile.

QEMU has a specific disk format called *qcow2* which allows for further capabilities. 

`qemu-img` is a tool capable of creating such images.

`man qemu-img` says that qcow2 can also do:

> smaller images (useful if your filesystem does not supports holes, for example on Windows), optional AES encryption, zlib based compression and support of multiple VM snapshots

## fda

Boot from given floppy image.

<https://github.com/dcloues/os_tutorial> can only be run with it.

Must be used when `grub.cfg` uses:

	root (fd0)

## ARM in x86

<https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Virtual_ARM_Linux_environment>

## During emulation

If on a GUI window, closing it kills the VM.

The same effect can be achieved with:

    shutdown

## GDB

### GDB on boot sector

<http://stackoverflow.com/questions/28811811/using-gdb-in-16-bit-mode/32925370#32925370>

    qemu-system-x86_64 -hda boot.img -S -s &
    gdb -ex 'target remote localhost:1234' -ex 'break *0x7c00' -ex 'continue'

The first instruction to be run is *not* your bot sector, but rather (TODO confirm) the BIOS code at address `0x0000fff0`. See also: <http://stackoverflow.com/questions/31296422/why-do-the-bytes-0xea-0000-ffff-in-a-bootloader-cause-the-computer-to-reboot>

So the first thing you do should be:

Note that symbol names won't help, because there is no debugging information in boot sectors!

### GDB on kernel

<http://stackoverflow.com/a/33203642/895245>

## Switch TTY

On Ubuntu 14.04, `Ctrl + Alt + Fx` changes the TTY on the host, for guest use Alt + Left / Right: <http://askubuntu.com/questions/54814/how-can-i-ctrl-alt-f-to-get-to-a-tty-in-a-qemu-session>

## User mode

QEMU can also emulate just processor to run compiled executables.

The QEMU executables for this are named as:

    qemu-ARCH

unlike the full system emulators which are named;

    qemu-system-ARCH

E.g.:

    qemu-x86_64 `which cpuinfo`
    qemu-i386 program

In Ubuntu 14.04, you need a separate package `qemu-user` for those.

Of course, you can only run those programs if your OS can handle their system calls and required dynamic libraries are present compiled for that arch.

`qemu-x86_64` refuses to run IA32 executables even though they run natively on Linux.

## bios

## UEFI

## OVMF

You can use UEFI instead of BIOS by downloading `OVMF.fd` and using:

    qemu-system-x86 -bios OVMF.fd [other opts]

See: <http://unix.stackexchange.com/a/228053/32558>

The Linux 4.2 kernel works out-of-the-box with it.

## append

Pass kernel boot parameters (command line arguments):

    -append "init=/dev/sbin panic=1"

## drive

QEMU 2.3.0 complains with a warning if we don't set `format`, so in this version we have to use:

    qemu-systemi386 -drive 'file=my.img,format=raw'

## Internals

### Create your own hardware emulator that works with QEMU

<http://ilevex.eu/post/88944209761/how-to-create-a-custom-pci-device-in-qemu>

## Performance simulation

Nope, QEMU is just designed to be fast, and performance is not well documented because it would reveal too much internals:

- <http://stackoverflow.com/questions/17454955/can-you-check-performance-of-a-program-running-with-qemu-simulator>
- <http://stackoverflow.com/questions/14259542/cycle-accurate-simulation-of-x86-hardware>
- <https://en.wikipedia.org/wiki/Computer_architecture_simulator>

## GPU

-   <http://stackoverflow.com/questions/5789418/how-do-i-add-a-virtual-gpu-into-qemu>
    - <http://stackoverflow.com/questions/5762039/create-virtual-hardware-kernel-qemu-for-android-emulator-in-order-to-produce-o/5763466#5763466>

## static

Ubuntu 16.04:

    sudo apt-get intall qemu-user-static

Usermode emulation. E.g., get a Linux ARM statically linked executable on an x86 machine, then you can run it with:

    qemu-arm-static ./executable

QEMU emulates the ISA, and converts system calls to the host arch! Amazing.

`-L` can be used to run with dynamic libraries: <http://stackoverflow.com/questions/16158994/qemu-arm-cant-run-arm-compiled-binary>

    qemu-arm-static -L /usr/arm-linux-gnueabihf ./executable

## Monitor

Special mode that allows you to enter commands to QEMU.

Enter with: `Ctrl + Alt + 2`.

Leave with: `Ctrl + Alt + 1`.

Those allow you to observe the program state without using an external debugger like GDB. GDB is more powerful however.

TODO: example.

### Monitor telnet from host:

Run QEMU with:

    -monitor telnet:127.0.0.1:1234,server,nowait \

Then:

    telnet localhost 1234

## Access host IP from QEMU

By default, the guest sees the host on a network at address 10.0.2.2.

To try this out, run on the host:

    python -m SimpleHTTPServer

and inside a BusyBox image do:

    wget 10.0.2.2:8000
    cat index.html

### Access QEMU IP from host

<http://unix.stackexchange.com/questions/124681/ssh-from-host-to-guest-using-qemu>

Looks like:

    -net user,hostfwd=tcp::2222-:22

## Shared filesystem with host

For simpler applications, just use `nc` or `wget`

NFS: TODO example. With this you can just mount a filesystem on the guest and it synchronizes automagically. Buildroot does have an NFS package.

Without networking: <http://superuser.com/questions/628169/qemu-to-share-a-directory-with-the-host>

## Serial

## TTL

TODO: like the serial present on most dev boards, which gives a shell that can be accessed with:

    telnet localhost 1234

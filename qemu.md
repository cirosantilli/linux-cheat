# QEMU

First learn that emulation and virtualization are different: <http://stackoverflow.com/questions/6044978/full-emulation-vs-full-virtualization>

QEMU is originally a software-only emulator. However a kernel module for it was created that allows it to use KVM virtualization with the `-enable-kvm` flag, which is much faster.

QEMU is used a lot in the context of Linux kernel development. Understanding all it's options is a great way to learn Linux kernel packaging.

The top 3 contributors are Red Hat employees.

<http://qemu.org>

<https://en.wikipedia.org/wiki/QEMU>

<https://github.com/qemu/qemu>

By default this talks about QEMU 2.0.0.

## Functional emulation

QEMU does a functional emulation of the CPU, i.e. it does everything as fast as possible, e.g. ignores caches and CPU pipelines.

Therefore, it does not give accurate timing results. But it is much faster than an accurate timing simulation.

The most popular realistic timing emulator for ARM is gem5, which is mainly developed by ARM Holdings itself.

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

How to access the QEMU monitor there (Ctrl + Alt + 1/2 on GUI): <http://stackoverflow.com/questions/14165158/how-to-switch-to-qemu-monitor-console-when-running-with-curses> This allows restoring the terminal after a panic with the monitor command:

    quit

## Display

### vnc

    ./qemu-system-x86_64 -vnc :0

Then on host:

    vinagre localhost:5900

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

The simplest image format is what you get when doing `dd` + `mke2fs`.

Those images are called raw images.

QEMU has a specific disk format called *qcow2* which allows for further capabilities. 

<https://en.wikipedia.org/wiki/Qcow>

`qemu-img` is a tool capable of creating such images.

`man qemu-img` says that qcow2 can also do:

> smaller images (useful if your filesystem does not supports holes, for example on Windows), optional AES encryption, zlib based compression and support of multiple VM snapshots

So basically it seems that the format allows holes.

Snapshot example that uses qcow2: <https://stackoverflow.com/questions/40227651/does-qemu-emulator-have-checkpoint-function/48724371#48724371>

Raw images can be potentially faster than qcow2 since there is no need to process hole metadata. But qcow2 is likely better on average.

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

### Monitor telnet from host

Run QEMU with:

    -monitor telnet::4444,server,nowait \

Then:

    telnet localhost 4444

This allows you to scroll up!

### Cool monitor commands

You can view and modify the full system state! :-)

- `sendkey p`; `sendkey w`; `sendkey d`; `sendkey ret`
- `stop`, `continue`
- `info`: lost of interesting machine info
    - `info registers`: dump CPU registers
    - `info tlb`: virtual to physical map. TODO vs `info mem`.
    - `info qtree`: device tree
    - `info ioapic`
- `x`, `xp`: dump memory
- `i`, `o`: IO port read and write
- `logfile my.log`, then `log in_asm`, `log out_asm`, `log int`, and others, will log every such event into a huge log. Likely should be used with GDB breakpoints.
- `gdbserver`: wait for GDB to connect during a session, like `-S` at startup

## Access host IP from QEMU

By default, the guest sees the host on a network at address `10.0.2.2`. This can be modified with `-net user,host=`.

To try this out, run on the host:

    python -m SimpleHTTPServer

and inside a BusyBox image do:

    wget 10.0.2.2:8000
    cat index.html

### Access QEMU IP from host

### Port forwarding

- <http://unix.stackexchange.com/questions/124681/ssh-from-host-to-guest-using-qemu>
- <https://serverfault.com/questions/704294/qemu-multiple-port-forwarding>

Launch QEMU:

    -net nic,model=virtio \
    -net user,hostfwd=tcp::4444-:4445 \

Then on guest, with BusyBox' `nc` with listen config enabled:

    nc -l -p 4445

Host with Ubuntu's `openbsd` `nc`:

    nc localhost 4444

and type away on either side!

TODO: can't do the opposite with this method? Listen from host. Likely not, since QEMU is already listening on host port.

## Shared filesystem with host

For simpler applications, just use `nc` or `wget`

NFS: TODO example. With this you can just mount a filesystem on the guest and it synchronizes automagically. Buildroot does have an NFS package.

Without networking: <http://superuser.com/questions/628169/qemu-to-share-a-directory-with-the-host>

## Serial

## TTL

### -serial file

To file worked:

    -append 'console=ttyS0' -serial file:qemu.log

but it is impossible to get input in this mode of course.

### -serial /dev/tty

TODO.

dev serial:

    -append 'console=ttyS0' -serial /dev/ttyS1

then:

    screen /dev/ttyS1 115200

fails.

### -serial stdio

Next:

    -serial stdio

is implied by `-nographic`, and just works (but the QEMU window stays open).

### -serial telnet

    -append 'console=ttyS0' -serial telnet::4444,server,nowait \

Then:

    telnet localhost 4444

### -serial tcp

Same as telnet?

    -append 'console=ttyS0' -serial tcp::4444,server,nowait \

Then:

    telnet localhost 4444

### Multiple -serial options

TODO. Only one got used in my tests.

https://stackoverflow.com/questions/39373236/redirect-multiple-uarts-in-qemu#comment85526416_39376502

## Custom hardware modelling

## Create new devices

Main goals:

- generate interrupts. E.g. a simple interrupt generator + Linux kernel handler. Haven't found anything pre-done. Good keyword is "interrupt injection".
- read and write to main memory / IO ports. First experiment: represent an LED somehow (host file write?). Then GPIO.
    - IO ports are possible with `monitor` commands
    - memory reads are possible with monitor commands `x` and `xp`. But what we really want is to map to guest and host memory for efficiency:
        - <http://kvm.vger.kernel.narkive.com/rto1dDqn/sharing-variables-memory-between-host-and-guest>
        - <https://www.linux-kvm.org/images/e/e8/0.11.Nahanni-CamMacdonell.pdf>
        - <http://www.fp7-save.eu/papers/SCALCOM2016.pdf>

Links:

- <http://stackoverflow.com/questions/14869317/arm-interrupt-handling-in-qemu>
- <http://stackoverflow.com/questions/37028940/qemu-arm-custom-machine>
- <https://stackoverflow.com/questions/28315265/how-to-add-a-new-device-in-qemu-source-code>
- <https://stackoverflow.com/questions/8621376/emulating-a-nand-based-storage-device-in-qemu?rq=1>
- <https://github.com/texane/vpcie> Closest working thing I've seen so far. Serializes PCI on both sides, and sends it through TCP. Inefficient, and requires extra instrumentation. But might be good enough.
- <https://balau82.wordpress.com/2010/09/04/custom-hardware-modeling-with-qemu-elc-2010/>
- <https://github.com/Xilinx/qemu-devicetrees>
- <http://ieeexplore.ieee.org/document/5669197/> (2010, no source code?)
- <https://lists.nongnu.org/archive/html/qemu-devel/2011-06/msg01214.html>
- <http://vlang.com/> <https://github.com/coverify/vlang>
- <http://pavel-demin.github.io/red-pitaya-notes/led-blinker/> <https://github.com/pavel-demin/red-pitaya-notes>
- <http://lists.nongnu.org/archive/html/qemu-devel/2015-06/msg04227.html>
- <https://raspberrypi.stackexchange.com/questions/56373/is-it-possible-to-get-the-state-of-the-leds-and-gpios-in-a-qemu-emulation-like-t>
- <https://github.com/xatier/qemu-LED-demo> TODO check.
- <http://wiki.qemu.org/Features/GuestAgent>
- <https://en.wikibooks.org/wiki/QEMU/Devices>
- in tree: search for filenames containing `guest agent`, `ga`, `qmp`, `qapi`, `dev`
    Most interesting hits:
    - `docs`
    - `scripts`
    - `qga`
    - `make -j14 txt` autogenerates a few interesting docs, then look in `.gitignore`
- QMP, QAPI, QGA: only seem to do basic operations. Can only find how to inject NMIs, not other interrupts. Can't find how to watch memory.
- <https://stackoverflow.com/questions/10826261/how-kvm-handle-physical-interrupt>

Search terms:

- QEMU hardware modelling
- QEMU Verilog

Good devices to study:

- `misc`:
    - `edu`: `PCI`
    - `arm_integrator_debug`: `PLATFORM`
    - `pc-testdev`: `ISA`

### Devices

Each device has a bus it is attached to.

Try on monitor `info qdev`.

Then, a device can also contain some buses (bridge), e.g. the `pcihost` on the `main-system-bus`.

### Create IRQs

Have a look at what PCI is doing, and `irq.c` files.

First you have to allocate the IRQ, which sets its handler:

    qemu_irq *qemu_allocate_irqs(qemu_irq_handler handler, void *opaque, int n)

The handler does the real work, and it is called when you do:

    void qemu_set_irq(qemu_irq irq, int level)

So the real question is what the handler does.

For PCI, the handler just forwards to its bus via `pci_irq_handler` then `pci_change_irq_level` then:

    bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);

Where `bus` is a `PCIBus`.

For `edu`, this ends up calling:

    piix3_set_irq+0 at hw/pci-host/piix.c

where PIIX is the PCI IDE ISA Xcelerator Intel thing.

TODO: what line of code makes the CPU jump to the handler? `cpu_loop` then `cpu_exec` then `cpu_handle_interrup` 

### QOM

QEMU has a crazy class system embedded.

`TYPE_DEVICE` is the base class for all devices.

`TYPE_OBJECT` is the base of all classes

Then e.g. `TYPE_PCI` inherits `TYPE_DEVICE`, and specific PCI devices inherit `TYPE_PCI`.

Minimal docs at: <https://github.com/qemu/qemu/blob/master/include/qom/object.h>

## Replayable run traces

Interesting! <https://github.com/panda-re/panda>

## chardev

## device

`-chardev` for host side, `-device` for guest side, both linked by `id` and `chardev` option pairs.

`-device help` to list devices, `-device file,isa-serial` to list extra options of `isa-serial` device type.

### chardev file

Unidirectional guest to host.

Run QEMU:

    -chardev file,id=mydev0,path=hostpath \
    -device isa-serial,chardev=mydev0 \

In guest:

    echo a > /dev/ttyS0

In host:

    cat hostpath

### chardev pipe

Pipes are unidirectional, but we can do bidirectional with two pipes.

First:

    sudo mknod -m 777 hostpipe.in p
    sudo mknod -m 777 hostpipe.out p

Then:

    -chardev file,id=mydev0,path=hostpath \
    -device isa-serial,chardev=mydev0 \

Then `cat` and `printf` to `/dev/ttyS0`.

### chardev socket

    -chardev socket,id=mydev0,host=0.0.0.0,port=4444,server -device isa-serial,chardev=mydev0

On host:

    netcat localhost 4444

Guest can `cat` and `printf` to `/dev/ttyS0`, but nice 2 way communication like `netcat` is not too trivial: <https://unix.stackexchange.com/questions/22545/how-to-connect-to-a-serial-port-as-simple-as-using-ssh>

## Build

    ./configure \
        --enable-debug \
        --enable-sdl \
        --enable-trace-backends=simple \
        --extra-cflags="-O2 -DDEBUG_PL061=1" \
        --host-cc="/usr/bin/gcc" \
        --target-list="x86_64-softmmu" \
        --with-sdlabi=2.0 \
    ;

## Source tree

### System mode

Entry point: `vl.c`

<https://lists.gnu.org/archive/html/qemu-devel/2007-05/msg00175.html>

### User mode

`main`: `linux-user/main.c`

Calls `cpu_loop`.

Then the heart of execution is:

    while (1) {
        cpu_exec_start(cs);
        trapnr = cpu_exec(cs);
        cpu_exec_end(cs);

`hw`: specifies two things:

-   `-M`: machine descriptions: places buses and devices and exact CPU description:
    - `hw/i386/`: x86 machines, notably the huge `pc.c`
    - `hw/arm/`: ARM machines, e.g. `versatilepb.c`
-   `-device` devices. Most directories.

IRQ: final point seems to be: `arm_cpu_set_irq`

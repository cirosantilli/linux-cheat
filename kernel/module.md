# Module

There are things which are hard to do from regular user programs such as directly talking to hardware.

Some operations can be done via system calls, but if you want flexibility and speed, using the kernel ring is fundamental

However:

- it would be very complicated to recompile the kernel and reboot every time you make some modification
- the kernel would be huge if it were to support all possible hardware

Modules overcome those two problems exactly because they can be loaded into the kernel *while it is running* and use symbols that the kernel chooses to export TODO which

It then runs in the same address space as the kernel and with the same permissions as the kernel (basically do anything)

Compiled modules are special object files that have a `.ko` extension instead of `.o` they also contain module specific metadata

Device drivers (programs that enables the computer to talk to hardware) are one specific type of kernel modules

Two devices can map to the same hardware!

## Stable kernel interface

Kernel modules can use any internal interface of the kernel, although some are more visible than others.

But there is no stable kernel API for modules: if you don't add your driver to the kernel tree, it can break any time: <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/stable_api_nonsense.txt?id=v4.0>

## Configuration files

If file it gets read, if dir, all files in dir get read:

    sudo ls /etc/modprobe.d
    sudo ls /etc/modprobe.conf

Modules loaded at boot:

    sudo cat /etc/modules

## module-init-tools

### package version

From any of the commands, `--version`:

    modinfo --version

Package that provides utilities

### lsmod

List loaded kernel modules.

Info is taken from `/proc/modules`

    lsmod

Sample output:

    cfg80211              175574  2 rtlwifi,mac80211
    ^^^^^^^^              ^^^^^^  ^ ^^^^^^^,^^^^^^^^
    1                     2       3 4       5

1.  Name.

2.  Size.

3.  Number of running instances.

	If negative, TODO

4.  Depends on 1.

5.  Depends on 2.

To get more info:

    cat /proc/modules

Also contains two more columns:

- status: Live, Loading or Unloading
- memory offset: 0x129b0000

### modinfo

Get info about a module by filename or by module name:

    modinfo ./a.ko
    modinfo a

### insmod

    sudo insmod

Loads the module.

Does not check for dependencies.

### modprobe

List available modules relative path to `/lib/modules/VERSION/`:

    sudo modprobe -l

Load the module:

    sudo modprobe $m

Checks for dependencies.

Load module under different name to avoid conflicts:

    sudo modprobe vmhgfs -o vm_hgfs

Remove module:

    sudo modprobe -r $m

Check if dependencies are OK:

    sudo depmod -a

Get info about given `.ko` module file:

    m=a
    sudo rmmod $m

## makefile

Kernel modules are built using a makefile located at:

	/lib/modules/$(uname -r)/build

### includes

Header files come from the same directory as the makefile: `/lib/modules/$(uname -r)/build`.

TODO what is: `/usr/src/linux-headers-$(uname -r)/` ?

Those come directly from the kernel source tree.

### headers

See [this](#includes).

## Hardware communication

Talking to hardware always comes down to writing bytes in specific registers at a given memory addresses.

Some processors implement a single address space for memory and other hardware devices, and others do not.

However, since x86 is the most popular and it separates address spaces, every architecture must at least mimic this separation.

On x86, the following specialized instructions exist for port IO:

- `IN`: Read from a port
- `OUT`: Write to a port
- `INS/INSB`: Input string from port/Input byte string from port
- `INS/INSW`: Input string from port/Input word string from port
- `INS/INSD`: Input string from port/Input `doubleword` string from port
- `OUTS/OUTSB`: Output string to port/Output byte string to port
- `OUTS/OUTSW`: Output string to port/Output word string to port
- `OUTS/OUTSD`: Output string to port/Output `doubleword` string to port

However, you should avoid using those instructions directly in your device driver code since Linux functions abstract over multiple architectures (when possible) making your code more portable.

Those instructions cannot be used from an user space program since the kernel prevents those from accessing hardware directly.

The memory space for non-memory locations is called I/O ports or I/O space.

To use a port, you must first reserve it. To see who reserved what:

	sudo cat /proc/ioports

# proc filesystem

Offer access system information of user processes.

Files documented at:

    man proc

## proc really is a filesystem

Proc really is a "regular" filesystem and can me mounted wherever you want with `mount`. E.g.:

    mkdir /tmp/proc2
    sudo mount -t proc none /tmp/proc2
    readlink /tmp/proc2/self/cwd
    readlink /proc/self/cwd
    sudo umount /tmp/newproc

generates a second `proc`.

It is also listed under `/proc/filesystems` like all others.

It is just that system calls are implemented magically in it, e.g.:

- `readlink /proc/self` returns the current PID
- `sudo touch a` always fails: you cannot create files in `/proc`. There is no associated storage.

## Does proc need to be in /etc/fstab ?

Only if you want custom mount options:

<http://askubuntu.com/questions/181429/is-a-proc-mount-necessary-in-etc-fstab>

Not present in Ubuntu 14.04.

## Interesting files

-   numeric directories: `/proc/1/`, `/proc/2/`, ...:

    Contain standard directory structures with process info.

    This is why that dir is called `/proc`

-   `cat /proc/meminfo`: information on RAM memory

-   `cat /proc/modules`: information on modules

-   `cat /proc/sched_debug`: scheduler info for debugging

-   `cat /proc/slabinfo`: slab allocator info

-   `cat /proc/softirqs`: `softirq` info

-   `cat /proc/version`: Linux kernel version and other system info. Similar to `uname -a` output.

    <http://askubuntu.com/questions/2884/how-can-i-determine-the-version-of-the-running-kernel>

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

## /proc/devices

Information on registered character and block devices.

Does not consider files under `/dev/`, but registrations done for example via `alloc_chrdev_region`.

Sample lines:

    Character devices:
    1 mem
    4 tty

Which says that:

- major number 1 is taken device named `mem`
- major number 4 is taken device named `tty`

The device name is what was passed to the `alloc_chrdev_region` of the kernel internal API.

## /proc/stat

Sample output:

    cpu  1041524 890 258966 6401473 38194 10 5852 0 0 0
    cpu0 282332 316 66564 3531273 24715 6 3698 0 0 0
    cpu1 241328 55 76244 951641 1026 2 972 0 0 0
    cpu2 280238 178 66044 955538 3563 1 920 0 0 0
    cpu3 237624 340 50113 963019 8889 0 261 0 0 0
    intr 42234546 16 86830 0 0 0 0 0 0 1 [...]
    ctxt 130745461
    btime 1431232525
    processes 63385
    procs_running 1
    procs_blocked 1
    softirq 16098970 937 4031292 2138117 668544 531851 [...]

Points which are not obvious from `man proc`:

- `intr`: TODO

## /proc/[pid]

## Processes

`/proc` is likely called proc because for each PID it contains a directory `/proc/[pid]` which expose process information.

`man proc` explain in detail most entries.

We can test them out with:

    sleep 10 &
    cat /proc/$!/cmdline | hd

which gives:

    00000000  73 6c 65 65 70 00 31 30  00                       |sleep.10.|
    00000009

### fd

Process file descriptors.

In particular, `0`, `1` and `2` are `stdin`, `stdout`, and `stderr`, and could be used similarly to `/dev/tty`:

    echo a >/proc/self/fd/1

Outputs `a` to the stdout of the current shell.

## /proc/self

## self

Information about the current process:

Behaves like a symlink to `/proc/<PID>`, but is pure `/proc` magic, since it is like a symlink that looks different from every process: <http://unix.stackexchange.com/questions/34192/how-is-proc-self-implemented-in-linux>

## cpuinfo

## /proc/cpuinfo

TODO vs `/sys/bus/cpu`.

`lscpu` gets information from this file.

On x86, most (TODO all?) of this information comes from the `CPUID` instruction.

Information on CPUs:

    cat /proc/cpuinfo

Sample output (only one of my 4 cores):

    processor       : 0
    vendor_id       : GenuineIntel
    cpu family      : 6
    model           : 58
    model name      : Intel(R) Core(TM) i5-3210M CPU @ 2.50GHz
    stepping        : 9
    microcode       : 0x12
    cpu MHz         : 2501.000
    cache size      : 3072 KB
    physical id     : 0
    siblings        : 4
    core id         : 0
    cpu cores       : 2
    apicid          : 0
    initial apicid  : 0
    fpu             : yes
    fpu_exception   : yes
    cpuid level     : 13
    wp              : yes
    flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
    bogomips        : 4988.59
    clflush size    : 64
    cache_alignment : 64
    address sizes   : 36 bits physical, 48 bits virtual
    power management:

- `processor`: processor ID, one for each core
- `vendor_id`: is part of CPU ID and identifies the vendor
- `family`, `model` and `stepping` come directly from `CPUID`. Stepping is just another smaller version level: <https://en.wikipedia.org/wiki/Stepping_level>.

### cpuinfo flags

Meaning of all flags: <http://unix.stackexchange.com/questions/43539/what-do-the-flags-in-proc-cpuinfo-mean>

The names come from several sources: some are vendor specific like Intel and AMD, others are Linux only keywords.

### Check if CPU is 64 bit

### lm

    cat /proc/cpuinfo | grep flags | grep lm

`lm` is a `CPUID` flag that stands for Long Mode and indicates exactly support for 64 bit.

## /proc/sys

Contains kernel parameters.

Those can also be modified with `sysctl`. Options will be documented there.

## /proc/uptime

How long the system has been up for.

Used by the procps `uptime` utility.

Sample output:

    6729.78 23034.43

## /proc/loadavg

## Load average

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

    This number does not consider how many CPU cores you have. E.g., if you have 4 cores, then you can handle a load average of `4.0`.

    A good rule of thumb is: keep it below `0.7`. If it goes over, start investigating before things start break.

-   4: TODO

-   5: PID of the last process created on the system.

Used by tools such as `top`, `uptime`.

## /proc/mounts

List mounted filesystems:

    cat /proc/mounts

Sample output:

    rootfs / rootfs rw 0 0
    sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
    proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
    udev /dev devtmpfs rw,relatime,size=1872900k,nr_inodes=468225,mode=755 0 0
    devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000 0 0
    tmpfs /run tmpfs rw,nosuid,noexec,relatime,size=376740k,mode=755 0 0
    /dev/disk/by-uuid/e45497f8-6295-41da-ad8c-90dbbac264e8 / ext4 rw,relatime,errors=remount-ro,data=ordered 0 0
    none /sys/fs/cgroup tmpfs rw,relatime,size=4k,mode=755 0 0
    none /sys/fs/fuse/connections fusectl rw,relatime 0 0
    none /sys/kernel/debug debugfs rw,relatime 0 0
    none /sys/kernel/security securityfs rw,relatime 0 0
    none /run/lock tmpfs rw,nosuid,nodev,noexec,relatime,size=5120k 0 0
    none /run/shm tmpfs rw,nosuid,nodev,relatime 0 0
    none /run/user tmpfs rw,nosuid,nodev,noexec,relatime,size=102400k,mode=755 0 0
    none /sys/fs/pstore pstore rw,relatime 0 0
    /dev/sda5 /home/ciro ext4 rw,relatime,data=ordered 0 0
    systemd /sys/fs/cgroup/systemd cgroup rw,nosuid,nodev,noexec,relatime,name=systemd 0 0
    gvfsd-fuse /run/user/1000/gvfs fuse.gvfsd-fuse rw,nosuid,nodev,relatime,user_id=1000,group_id=1000 0 0

## /proc/partitions

Sample output:

    major minor  #blocks  name

       8        0  488386584 sda
       8        1    1536000 sda1
       8        2   97715052 sda2
       8        3   14336000 sda3
       8        4          1 sda4
       8        5  309445632 sda5
       8        6    3910656 sda6
       8        7   30718976 sda7
       8        8   30718750 sda8
      11        0    1048575 sr0

## /proc/interrupts

Explained at <https://github.com/cirosantilli/x86-bare-metal-examples/> because you have to understand the low level PIC stuff for that to make any sense.

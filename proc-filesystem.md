# proc filesystem

Offer access system information of user processes.

Files documented at:

    man proc

Some interesting files include:

-   numeric directories: `/proc/1/`, `/proc/2/`, ...:

    Contain standard directory structures with process info.

    This is why that dir is called `/proc`

-   `cat /proc/meminfo`: information on RAM memory

-   `cat /proc/modules`: information on modules

-   `cat /proc/mounts`: list all mounted filesystems and some info on them

-   `cat /proc/partitions`: `softirq` info

-   `cat /proc/sched_debug`: scheduler info for debugging

-   `cat /proc/self/`: information about the current process

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

## cpuinfo

## /proc/cpuinfo

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

### cpuinfo flags

Meaning of all flags: <http://unix.stackexchange.com/questions/43539/what-do-the-flags-in-proc-cpuinfo-mean>

The names come from several sources: some are vendor specific like Intel and AMD, others are Linux only keywords.

### Check if CPU is 64 bit

### lm

    cat /proc/cpuinfo | grep flags | grep lm

`lm` is a `CPUID` flag that stands for Long Mode and indicates exactly support for 64 bit.

## /proc/sys

Contains kernel parameters.

Those can also be modified with `sysctl`.

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

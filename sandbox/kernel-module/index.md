modules are loaded as object files
you can only use symbols defined by the kernel
list of them:

modules share memory space with the rest of the kernel
this means that if a module segfaults, the kernel segfaults!

    cat /proc/kallsyms

`.ko` extension used instead of `.o`
also contain module information

device drivers (programs that enables the computer to talk to hardware)
are one specific type of kernel modules

note that this causes great possibility of name pollution
so choose names carefully!

two devices can map to the same hardware!

# config files

if file it gets read, if dir, all files in dir get read:

    sudo ls /etc/modprobe.d
    sudo ls /etc/modprobe.conf

modules loaded at boot:

    sudo cat /etc/modules

# module-init-tools

## package version

from any of the commands, --version

    modinfo --version

package that provides utilities

## lsmod

list loaded kernel modules

info is taken from `/proc/modules`

    lsmod

sample output:

    cfg80211              175574  2 rtlwifi,mac80211
    ^^^^^^^^              ^^^^^^  ^ ^^^^^^^,^^^^^^^^
    1                     2       3 4       5

1. name
2. size
3. numer of running instances
4. depends on
5. depends on

to get more info:

    cat /proc/modules

also contains two more columns:

- status: Live, Loading or Unloading
- memory offset: 0x129b0000

## modinfo

    modinfo a.ko
    modinfo a

get info about a module

## insmod

loads the module
does not check for dependencies

    sudo insmod

## modprobe

list available modules relative path to /lib/modules/VERSION/:

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

# device drivers

    ls -l /dev

there are two types of devices: block and char

    crw-rw----  1 root tty       7,   1 Feb 25 09:29 vcs1
    ^
    c: char

    brw-rw----  1 root disk      8,   0 Feb 25 09:30 sda
    ^
    b: block

this is my hd.
each partition also gets a b file

## major minor numbers

    crw-rw----  1 root tty       7,   1 Feb 25 09:29 vcs1
        ^    ^
        1    2

- 1: major number. tells kernel which driver controls this file
- 2: minor number. id of each hardware controlled by a
    given driveer

## mknod

    sudo mknod /dev/coffee c 12 2

makes a char file, major number 12, minor number 2

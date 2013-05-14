# get version

    uname -r

    cat /proc/version

# sysctl

view/config kernel parameters at runtime

    sudo sysctl –a

# modules

`.ko` extension used instead of `.o`
also contain module information

device drivers (programs that enables the computer to talk to hardware)
are one type of kernel modules

modules are loaded as object files
you can only use symbols defined by the kernel
list of them:

    cat /proc/kallsyms

note that this causes great possibility of name pollution
so choose names carefully!

modules share memory space with the rest of the kernel
this means that if a module segfaults, the kernel segfaults!

two devices can map to the same hardware!

## rings

x86 concept

programs can run in different rings

4 rings exist

linux uses 2:

- 0: kernel mode
- 3: user mode

## config files

if file it gets read, if dir, all files in dir get read:

    sudo ls /etc/modprobe.d
    sudo ls /etc/modprobe.conf

modules loaded at boot:

    sudo cat /etc/modules

## module-init-tools

### package version

from any of the commands, --version

    modinfo --version

package that provides utilities

### lsmod

list loaded kernel modules

info taken from /proc/modules

    lsmod
        #cfg80211              175574  2 rtlwifi,mac80211
        #^^^^^^^^              ^^^^^^  ^ ^^^^^^^,^^^^^^^^
        #1                     2       3 4       5

- 1: name
- 2: size
- 3: numer of running instances
- 4: depends on
- 5: depends on

    cat /proc/modules

also contains two more columns:
status: Live, Loading or Unloading
memory offset: 0x129b0000

### moinfo

    modinfo a.ko
    modinfo a

get info about a module

### insmod

loads the module
does not check for dependencies

    sudo insmod

### modprobe

list available modules relative path to /lib/modules/VERSION/:

    sudo modprobe -l

    sudo modprobe $m
loads the module
checks for dependencies

    sudo modprobe vmhgfs -o vm_hgfs
load module under different name
to avoid conflicts

    sudo modprobe -r $m
remove module

    sudo depmod -a
chekc dependencies are ok

    m=a
    sudo rmmod $m
get info about given .ko module file

## device drivers

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

### major minor numbers

crw-rw----  1 root tty       7,   1 Feb 25 09:29 vcs1
    ^    ^
    1    2
1: major number. tells kernel which driver controls this file
2: minor number. id of each hardware controlled by a
    given driveer

### mknod

    sudo mknod /dev/coffee c 12 2

makes a char file, major number 12, minor number 2

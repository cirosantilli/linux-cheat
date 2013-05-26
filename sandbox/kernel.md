the kernel is the part of the system which does the most fundamental operations,
in special low level hardware dependant ones. this allows for:

- hardware independance: all programs make identical system calls to the kernel
    without thinking about the hardware

- process control: the kernel determines what programs can do or not,
    enforcing for example file permissions

user programs can only access the kernel services via system calls.

the linux kernel is written on mainly on c c99 standard,
with **gasp** gcc extensions. Therefore the linux kernel is married to gcc.

# rings

x86 implemented concept

programs can run in different rings

4 rings exist

linux uses 2:

- 0: kernel mode
- 3: user mode

this is used to separate who can do what

# install a new kernel

TODO

# get kernel version

    uname -r

    cat /proc/version

# sysctl

view/config kernel parameters at runtime

    sudo sysctl –a

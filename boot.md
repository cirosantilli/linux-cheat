# Boot

Info on the boot process and its configuration.

First you must understand the non-Linux-specifics with minimal examples: <https://github.com/cirosantilli/x86-bare-metal-examples>

## boot directory

Usually located at `/boot/`.

Contains the following Linux specific files:

- `config-VERSION`: the kernel configuration options, generated at configuration before kernel compilation by `make menuconfig`
- `abi-VERSION`: TODO what is? Looks like the kernel symbol table of exported symbols.

### vmlinuz

Compiled kernel compressed with gzip, thus the `Z`

#### vmlinux

#### bzimage

<http://unix.stackexchange.com/questions/5518/what-is-the-difference-between-the-following-kernel-makefile-terms-vmlinux-vml>

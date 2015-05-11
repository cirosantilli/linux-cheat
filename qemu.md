# QEMU

Lightweight virtualization.

TODO how does it work internally?

TODO how portable is it?

<http://qemu.org>

<https://en.wikipedia.org/wiki/QEMU>

<https://github.com/qemu/qemu>

Boot a live ISO, e.g. one generated with <https://github.com/ivandavidov/minimal>:

## Generate an image

TODO

## Use an image

Open a new X Window running the booted image:

    qemu-system-x86_64 -cdrom minimal_linux_live.iso

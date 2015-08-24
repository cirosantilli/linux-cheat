# Minimal distros

Minimal distros are a great way to understand what a distribution is made of, and how it interfaces with the kernel.

"Serious" minimal distros usually target embedded systems like phones, cars, routers, etc. in which storage and computing capacity is limited.

## Minimal Linux Live

<https://github.com/ivandavidov/minimal>

<http://stackoverflow.com/a/30056630/895245>

By default, this distribution only boots the RAM `initrd`: anything you do is lost after shutdown.

## Buildroot

System to build distro images locally

<http://buildroot.uclibc.org/>

## Yocto Project

<http://www.yoctoproject.org>

Similar to Buildroot.

Supported by the Linux Foundation.

## Alpine Linux

<https://www.alpinelinux.org/>

<https://en.wikipedia.org/wiki/Alpine_Linux>

One step beyond Minimal Linux Live: includes a libc and a package manager with many, many packages.

## Linux from scratch

<http://www.linuxfromscratch.org/>

Linux from scratch, mostly educational.

Teaches how to build a minimal Linux distro from base standard packages.

Not very automated, although there is an automated version at: <http://www.linuxfromscratch.org/alfs/>

## Damn small Linux

<https://en.wikipedia.org/wiki/Damn_Small_Linux>

Seemed popular, but died in 2008?

## TODO test

Tiny core Linux: <http://tinycorelinux.net/>, source: <http://git.tinycorelinux.net/index.cgi> Minimalistic with X.

Minimalistic, text based, security: <http://rlsd2.dimakrasner.com/>

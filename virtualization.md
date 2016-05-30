# Virtualization

Virtualization tools such as VirtualBox, Vagrant or Docker.

## Introduction

Virtualization is running an operating system inside another one without rebooting.

In this context, the main system is called the *host*, and the one running inside the *guest*.

To interface with the guest from the host, you can either either use:

-   a window inside the host as in [this video](http://www.youtube.com/watch?feature=player_detailpage&v=hK-oggHEetc&t=723).

    This is the case for VirtualBox.

-   ssh. The machine redirects one port of the host to itself through which it is possible to interact over ssh.

    Vagrant makes this type of usage very simple.

Filesystem may be set to be a file on the host representing the filesystem.

Use a minimal distribution like Minimal Linux Live to better understand how virtualization tools work.

Once you are done emulating a hardware you own, run things on the actual hardware to see if it *really* works as expected.

## Applications

-   switch quickly between the two OS without reboot or the need to partition your disk.

    -   use programs from both at the same time.

        You could for example run a Windows game on a guest, and listen music with Totem on your Linux host.

    -   test program on many different OS.

        You could for example create a VM for

-   no need to partition your disk

-   VM reboot is faster than a host reboot, specially considering that your host is likely to open many programs at startup, while the guest will open up a minimum system for your specific purposes.

    This may be important for example when testing kernel modules, since an error
    means you have to reboot.

-   make a sandbox where you can do what ever test you want to, including tests which could damage your host machine's HD.

    You could for example test Linux kernel modules or kernel modifications.

-   control hardware conditions.

    This allows you to test your programs on low memory conditions or on different architectures (supported by some VMs).

-   save state

    You can save the entire system state, and then go back to it exactly.

-   share folders

    Some VMs allow sharing of folders between host and guest.

    This can be useful if you want for example to test a program on multiple systems, so you just share a folder over all machines.

    Another advantage of sharing is that you can test on the target system, but develop from the comfort of your host system.

Downsides:

-   performance loss on the guest system since there are two OSs running on a single machine.

-   additional level of complexity, possibly causing hard to solve errors. In practice however, we find VMs like VirtualBox to reproduce host systems very well.

Important niche of application for VMs include:

-   gaming, to run games from other platforms such as a Windows game on Linux.

-   web app deployment, where it is necessary to control every aspect of the system.

    This is used for example by AWS.

## Types of virtualization

## Hardware support

## Emulation vs virtualization

<http://stackoverflow.com/questions/6044978/full-emulation-vs-full-virtualization>

Emulation is usually said to be software only, while virtualization uses hardware support, making it way faster.

The x86 family has hardware features that improve performance and may be even required for certain virtualizations.

Those features can be turned on or off by the BIOS, and in many modern systems they come turned off by default.

If you plan on using virtualization, the first thing you should do is to enable such features by going into the BIOS config (first screen shown at computer startup), and looking for a virtualization section.

Docker: <https://github.com/dotcloud/docker>

### Hypervisor

TODO vs virtualization?

- type 1: runs directly on the hardware. You boot into it to start with. E.g.: Xen
- type 2: runs on top of an OS. E.g.: VirtualBox.

KVM: hard to say.

## Cycle accurate simulation

Simulates speed well.

Public simulators do not exist for closed source chips I know of.

Likely because they would reveal too much internals and leak IP.

## File formats

### ovf

[OVF](http://en.wikipedia.org/wiki/Open_Virtualization_Format) is one open virtual machine format that is supported across the most popular VM runners, including VirtualBox and VMware.

### box

Native VirtualBox format.

### vmdk

Native VMware format.

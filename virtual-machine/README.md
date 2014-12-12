# Virtual machine

Virtualization tools such as VirtualBox, Vagrant or Docker.

## Introduction

Virtualization is running an operating system inside another one without rebooting.

In this context, the main system is called the *host*, and the one running inside the *guest*.

To interface with the guest from the host, you can either either use:

- a window inside the host as in [this video](http://www.youtube.com/watch?feature=player_detailpage&v=hK-oggHEetc&t=723).

    This is the case for VirtualBox.

- ssh. The machine redirects one port of the host to itself through which it is possible to interact over ssh.

    Vagrant makes this type of usage very simple.

Filesystem may be set to be a file on the host representing the filesystem.

## Applications

- switch quickly between the two OS without reboot or the need to partition your disk.

    - use programs from both at the same time.

        You could for example run a Windows game on a guest,
        and listen music with Totem on your Linux host.

    - test program on many different OS.

        You could for example create a VM for

- no need to partition your disk

- VM reboot is faster than a host reboot, specially considering that your host is likely to open many programs at startup, while the guest will open up a minimum system for your specific purposes.

    This may be important for example when testing kernel modules, since an error
    means you have to reboot.

- make a sandbox where you can do what ever test you want to, including tests which could damage your host machine's HD.

    You could for example test Linux kernel modules or kernel modifications.

- control hardware conditions.

    This allows you to test your programs on low memory conditions or on different architectures (supported by some VMs).

- save state

    You can save the entire system state, and then go back to it exactly.

- share folders

    Some VMs allow sharing of folders between host and guest.

    This can be useful if you want for example to test a program on multiple systems, so you just share a folder over all machines.

    Another advantage of sharing is that you can test on the target system, but develop from the comfort of your host system.

Downsides:

- performance loss on the guest system since there are two OSs running on a single machine.
- additional level of complexity, possibly causing hard to solve errors. In practice however, we find VMs like VirtualBox to reproduce host systems very well.

Important niche of application for VMs include:

- gaming, to run games from other platforms such as a Windows game on Linux.
- web app deployment, where it is necessary to control every aspect of the system.

    This is used for example by AWS.

## Alternatives to virtual machines

- wine.

    Implements the Windows API, so you can run programs just like:

        wine notepad.exe

    Harder to get things working than inside a VM, since it is a complete API reimplementation.

    Windows only.

- Docker: <https://github.com/dotcloud/docker>

## Hardware support

The x86 family has hardware features that improve performance and may be even required for certain virtualizations.

Those features can be turned on or off by the BIOS, and in many modern systems they come turned off by default.

If you plan on using virtualization, the first thing you should do is to enable such features by going into the BIOS config (first screen shown at computer startup), and looking for a virtualization section.

## Formats

### ovf

[OVF](http://en.wikipedia.org/wiki/Open_Virtualization_Format) is one open virtual machine format that is supported across the most popular VM runners, including VirtualBox and VMware.

### box

Native VirtualBox format.

### vmdk

Native VMware format.

## VirtualBox

Open source cross platform option by Oracle.

Create a VM with default configuration.

If all you want to do is develop on a command line, forget the VirtualBox GUI, and go directly for Vagrant, which is much more automated for that purpose.

All you have is an empty disk (disk file), but it cannot know where to boot from since it does not see you HD. Go: `settings > storage > click on the disk button` as shown on [this video](http://www.youtube.com/watch?feature=player_detailpage&v=hK-oggHEetc&t=538) and select a Live ISO for you desired distro. This ISO is mounted on the virtual DVD reader.

Start running the system, and since the virtual HD is empty, it will boot from the ISO. Install that system. It will be just like installing on an empty HD. Reboot and you have a working system.

Certain key combinations are always captured by the host, such as Ctrl-Alt-Del or Ctrl-Alt-BACKSPACE. You can send any Ctrl-Alt-KEY combination by using host_key + KEY, where host_key is right control version 4.2.

### guest utils

Certain features require that you install VirtualBox utilities on the guest, for example directory sharing.

You should *really* install that immediately after you get your host working, since some very basic features may require those utils to work (X server on Linux for example).

If your distribution has a package manager, it is possible that you can install the utils on the guest via the package manager: this is the case for Ubuntu 13.04 for example. This should be your preferred method if available.

Otherwise, see [this](http://www.virtualbox.org/manual/ch04.html#idp11306688) for how to install.

If you don't have X, you may be able to switch to terminal mode via some special key combination (Ctrl-Alt-F2 on Ubuntu for example) install the utils via the terminal, and then reboot.

### box location

Box state machines are stored under: `~/VirtualBox VMs/`.

## VMware

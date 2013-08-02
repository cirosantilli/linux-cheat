This is about system virtualization, that is, running another operating system while you are running another one.

Typically, the new OS will show up in a window inside the host as in
[this video](http://www.youtube.com/watch?feature=player_detailpage&v=hK-oggHEetc&t=723).

Filesystem may be set to be a file on the host representing the filesystem.

Applications:

- switch quickly between the two OS without reboot or the need to partition your disk.

    - use programs from both at the same time.

        You could for example run a Windows game on a guest,
        and listen music with Totem on your Linux host.

    - test program on many different OS.

        You could for example create a VM for

- no need to partition your disk

- VM reboot is faster than a host reboot, specially considering that your host
    is likely to open many programs at startup, while the guest will open up
    a minimum system for your specific purposes.

    This may be important for example when testing kernel modules, since an error
    means you have to reboot.

- make a sandbox where you can do what ever test you want to,
    including tests which could damage your host machine's HD.

    You could for example test Linux kernel modules or kernel modifications.

- control hardware contitions.

    This allows you to test your programs on low memory conditions
    or on different architectures (supported by some VMs)

- save state

    You can save the entire system state, and then go back to it exactly.

- share folders

    Some VMs allow sharing of folders between host and guest.

    This can be useful if you want for example to test a program on multiple systems,
    so you just share a folder over all machines.

Downsides:

- performance loss on the guest system since there are two OSs running on a single machine.

#virtualbox

Open source cross platform option by Oracle.

Install on your host.

Create a VM with default config.

All you have is an empty disk (disk file), but it cannot know where to boot from
since it does not see you HD.
Go: `settings > storage > click on the disk button` as shown on
[this video](http://www.youtube.com/watch?feature=player_detailpage&v=hK-oggHEetc&t=538)
and select a Live ISO for you desired distro. This ISO is mounted on the virtual DVD reader.

Start running the system, and since the virtual HD is empty, it will boot from the ISO.
Install that system. It will be just like installing on an emtpy HD.
Reboot and you have a working system.

Certain key combinations are always captured by the host, such as <C-A-DEL> or <C-A-BACKSPACE>.
You can send any <C-A-KEY> combination by using host_key + KEY, where host_key is right control version 4.2.

##guest utils

Certain features require that you install virtualbox utilities on the guest,
for example directory sharing.

You should *really* install that immediately after you get your host working,
since some very basic features may require those utils to work (X server on Linux for example).

If your distribution has a package manager, it is possible that you can install the utils on
the guest via the package manager: this is the case for Ubuntu 13.04 for example.
This should be your preferred method if available.

Otherwise, see [this](http://www.virtualbox.org/manual/ch04.html#idp11306688) for how to install.

If you don't have X, you may be able to switch to terminal mode via some special key combination
(Ctrl-Alt-F2 on Ubuntu for example) install the utils via the terminal, and then reboot.

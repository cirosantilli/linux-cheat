# VirtualBox

Open source cross platform option by Oracle.

Create a VM with default configuration.

If all you want to do is develop on a command line, forget the VirtualBox GUI, and go directly for Vagrant, which is much more automated for that purpose.

All you have is an empty disk (disk file), but it cannot know where to boot from since it does not see you HD. Go: `settings > storage > click on the disk button` as shown on [this video](http://www.youtube.com/watch?feature=player_detailpage&v=hK-oggHEetc&t=538) and select a Live ISO for you desired distro. This ISO is mounted on the virtual DVD reader.

Start running the system, and since the virtual HD is empty, it will boot from the ISO. Install that system. It will be just like installing on an empty HD. Reboot and you have a working system.

Certain key combinations are always captured by the host, such as Ctrl-Alt-Del or Ctrl-Alt-BACKSPACE. You can send any Ctrl-Alt-KEY combination by using host_key + KEY, where host_key is right control version 4.2.

## Guest utils

Certain features require that you install VirtualBox utilities on the guest, for example directory sharing.

You should *really* install that immediately after you get your host working, since some very basic features may require those utils to work (X server on Linux for example).

If your distribution has a package manager, it is possible that you can install the utils on the guest via the package manager: this is the case for Ubuntu 13.04 for example. This should be your preferred method if available.

Otherwise, see [this](http://www.virtualbox.org/manual/ch04.html#idp11306688) for how to install.

If you don't have X, you may be able to switch to terminal mode via some special key combination (Ctrl-Alt-F2 on Ubuntu for example) install the utils via the terminal, and then reboot.

## Box location

Box state machines are stored under: `~/VirtualBox VMs/`.

## Instruction sets

Virtualbox exposes only a subset of the host's instruction set. This cannot be customized.

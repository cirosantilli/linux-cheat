# VirtualBox

If you only want command line emulation, use the Vagrant front-end for VirtualBox. It rules.

## Ubuntu Quick start

Restart your computer, and from the BIOS setup screen, enable hardware virtualization. This will make VirtualBox *much* faster.

Let's emulate one Ubuntu inside another:

    wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian precise non-free contrib" >> /etc/apt/sources.list.d/virtualbox.org.list'
    sudo aptitude update
    sudo aptitude install -y virtualbox-4.3

Download an Ubuntu `.iso` image from the official website.

Launch VirtualBox, and create a new image. Use the default settings.

Insert the ISO into the virtual drive:

- Settings
- Storage
- Click on the disk icon as shown on this video: <http://www.youtube.com/watch?feature=player_detailpage&v=hK-oggHEetc&t=538>

and select a Live ISO we've downloaded.

From there on, install Ubuntu as you would on regular hardware, and restart.

## Introduction

Open source cross platform option by Oracle.

Create a VM with default configuration.

If all you want to do is develop on a command line, forget the VirtualBox GUI, and go directly for Vagrant, which is much more automated for that purpose.

## Mouse and keyboard

Certain key combinations are always captured by the host, such as Ctrl-Alt-Del or Ctrl-Alt-BACKSPACE.

You can send any Ctrl-Alt-KEY combination by using host_key + KEY, where host_key is right control version 4.2.

There are also hosts that support VM integration: this allows you to capture the mouse automatically when you hover the VM window.

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

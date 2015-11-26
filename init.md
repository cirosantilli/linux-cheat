# init

Information about the init process and related concepts such as system V init system.

First user-space process and parent of all processes!

It has PID 1.

It is the first child of the first kernel process, which has PID 0.

Last thing that is run at boot process.

Determines runlevel.

A great way to understand what happens after `init` is to use `pstree`.

This is distribution dependent.

## rc.local

## Run levels

## System V init system

Ubuntu currently uses both System V init and the newer (backwards compatible) Upstart alternative.

The exact meaning of levels varies based the exact UNIX variant. The most common across distros are:

- 0. Halt
- 1. Single user mode (aka. S or s)
- 6. Reboot

In addition, every distro has a "normal" runlevel for mos of its operation which is either 2 (Ubuntu) or 3 (SUSE, Mac OS X) in most distributions.

Each runlevel is a directory under `/etc` of the form `/etc/rcX.d` containing symlinks to bash scripts with an specific format, all of which should be under `/etc/init.d/`.

Those files are kept under `init`, because all of those scrips are run by the `init` process by forking. This can be observed through commands like `pstree`.

TODO: must all scripts have filenames of type: `[SK]NN`? I have seen that `S` scripts are run before `K`, and then within `SK`, scripts are run by increasing `NN`.

Therefore this is a POSIX 7 supported concept.

The LSB goes further and specifies:

- 0: Halt: Shuts down the system.
- 1: Single-user Mode: Mode for administrative tasks.
- 2: Multi-user Mode: Does not configure network interfaces and does not export networks services.
- 3: Multi-user Mode with Networking: Starts the system normally.
- 4: Not used/User-definable: For special purposes.
- 5: Start the system normally with appropriate display manager. ( with GUI ): Same as runlevel 3 + display manager.
- 6: Reboot: Reboots the system.

Get current runlevel (POSIX 7):

    who -r

### init.d

`/etc/init.d` holds System V scripts, which are then symlinked from `/etc/rcX/[SK]XXname` files.

`/etc/init` is Upstart specific.

### init command

Set runlevel to 6, causing the system to reboot:

    #sudo init 6

### chkconfig

Ubuntu install before 14.04:

    sudo aptitude install -y chkconfig

Removed in 14.04 and replaced by `sysv-rc-conf`.

Show table saying which service is on at which runlevel:

    chkconfig --list

Sample output:

    acpi-support              0:off  1:off  2:on   3:on   4:on   5:on   6:off
    acpid                     0:off  1:off  2:off  3:off  4:off  5:off  6:off

Show only for a single service:

    chkconfig --list apache2

### initctl

Show status of all services:

    sudo initctl list

Like `sudo service --status-all` but for System V.

## /etc/init.d

System V scripts, which will be symlinked from the `rc.d` directories.

### /etc/inittab

System V configuration file.

Not used in Upstart.

To learn it, use this: <https://github.com/ivandavidov/minimal/blob/9797b843d117b520919471c45f6c1fe5f1e916d6/src/5_generate_rootfs.sh#L81>

### Ubuntu specific

`/etc/defaults/name` are shell scripts that contain environment variables which can be used by the corresponding init script. Rationale: scripts can be updated without destroying parameters. File in `defaults` are never changed by the package manager.

### update-rc.d

CLI tool that manages System V symlinks between `/etc/rcX` and  `/etc/init.d`.

Prevent a service from starting at startup (removes the symlink):

    sudo update-rc.d apache2 disable

Enable a service:

    sudo update-rc.d apache2 defaults

Set the `<start><stop>` levels of the script script:

    sudo update-rc.d apache2 defaults 21

The above sets start to `2` and stop to `1`.

## init directory

`/etc/init` is Upstart specific. It contains scripts that correspond to Upstart services.

## upstart

Intended as a backwards compatible replacement for System V.

Major advantage: automatically deals with dependency order, while in System V you have to linearize the dependencies manually.

Used in Ubuntu 12.04 and 14.14, but will be replaced by `systemd` in the future.

Good sources:

-   <http://upstart.ubuntu.com/getting-started.html>

    Good intro, but few options commented.

-   <http://upstart.ubuntu.com/cookbook/>

    Very good manual.

<http://askubuntu.com/questions/2075/whats-the-difference-between-service-and-etc-init-d>

### service

Upstart interface to init scripts.

Get status of all services:

    sudo service --status-all

Legend:

- `+`: started
- `-`: stopped
- `?`: unknown

Examples:

    sudo service apache2 status
    sudo status apache2

    sudo service apache2 start
    sudo start apache2

    sudo service apache2 stop
    sudo stop apache2

    sudo service apache2 restart
    sudo restart apache2

Service only works for Upstart services, it does not see System V ones.

### /etc/init

Upstart configuration files

Named services that can be used via:

    sudo service XXX start

correspond to:

    /etc/init/XXX.conf

files in this directory.

#### start on

Determines event when the startup script will start.

Required to start script automatically at startup: if missing it won't start.

The service must start only once all of its requirements have already done so.

To start after the very basic facilities are set up(e.g. filesystems and networking) the manual recommends either:

    start on runlevel [2345]

    start on (local-filesystems and net-device-up IFACE!=lo)

To start after `/etc/fstab` mountings have been done on Ubuntu 12.04, use:

    start on stopped mountall

### Disable upstart services at boot

The only way seems to be manually modifying the file to comment out the `start` line:

<http://askubuntu.com/questions/19320/how-to-enable-or-disable-services>

### sysv-rc-conf

ncurses manager of Upstart scripts.

Analogous to `chkconfig` for System V.

## systemd

Newer alternative to Upstart.

Enabled by default on Arch, Red Hat, Debian, and planned on Ubuntu.

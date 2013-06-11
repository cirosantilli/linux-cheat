info on how a linux system starts running

summary of the boot process: <http://www.ibm.com/developerworks/library/l-linuxboot/>

# grub

to edit the configs:

    sudo vim /etc/default/grub

- `GRUB_DEFAULT`: default os choice if cursor is not moved.

	starts from 0, the order is the same as shown at grub os choice menu

- `GRUB_TIMEOUT` : time before auto OS choice in seconds

after changing the configs you need to:

    sudo update-grub

# init

first user-space process and parent of all processes!

last thing that is run at boot process

determines runlevel

    sudo init 6

set runlevel to 6 which implies a reboot

# run levels

ubuntu uses upstart, newer replacement to `system v` init

- `/etc/init`: upstart configuration files

	programs here are named services

- `/etc/init.d`: the old compatibility only system v initi dirs

	links to programs that get run on each runlevel at `/etc/rc\n.d/`

determines previous and current run level

	runlevel

# upstart

## service

upstart interface to services

get status of all services:

    sudo service --status-all

legend:

- `+`: started
- `-`: stopped
- `?`: unknow

    sudo service apache2 status
    sudo status apache2

    sudo service apache2 start
    sudo start apache2

    sudo service apache2 stop
    sudo stop apache2

    sudo service apache2 restart
    sudo restart apache2

TODO `service restart` vs `restart`?

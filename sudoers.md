# sudoers

# /etc/sudoers

Configuration file for sudo.

    man sudoers

## visudo

Edit `/etc/sudoers` safely:

    sudo visudo

Never use `sudo vi /etc/sudoers`. TODO why.

Analogous to `vipw` for the `passwd` file.

## Syntax

### Defaults

Configuration parameters for chosen users.

### timestamp_timeout

After any user enters a pass, he can sudo without pass for 15 minutes:

    Defaults timestamp_timeout=15

Turn it off. Better for safety:

    Defaults timestamp_timeout=0

### secure_path

Sets a path to be used by `sudo` instead of the caller's, including if `-u` is used.

Try things out with:

    sudo -iu $USER env

TODO:

- how is this implemented?
- what is the advantage of this? If you've got sudo, you can destroy the system already no?
- how does RVM get around this? It's paths stay even upon `sudo`.

Ubuntu 15.10 sets this to a reduced list of "trusted" paths by default.

### Main part

Determines who can run as whom with sudo, and what that user can run.

TODO: improve this mess.

    user hostip=(runas)NOPASSWD ALL

    %group hostip=(runas)    :/bin/ls,/bin/cat
    user: who will get sudo premissions
    add '%' for group: ex: %group ...
    can be ALL

    runas: who can he sudo as

    NOPASSWD: if present, must enter target user's password

    /bin/ls,/bin/cat: list of comma separated bins he can run, or ALL

#### Aliases

User:

    User_Alias FUSE_USERS = andy,ellz,matt,jamie
    FUSE_USERS ALL=(root):/usr/bin/the-application

Host:

    Host_Alias HOST = jaunty
    %admin HOST=(ALL)

Runas:

    Runas_Alias USERS = root,andy,ellz,matt,jamie
    %admin ALL=(USERS) ALL

Command:

    Cmnd_Alias APT   = /usr/bin/apt-get update,/usr/bin/apt-get upgrade
    Cmnd_Alias USBDEV = /usr/bin/unetbootin,/usr/bin/gnome-format
    ALL_PROGS = APT,USBDEV
    %admin ALL=(ALL) ALL

#### Allow user to sudo without password

Allow given user to sudo without password:

    username ALL=(ALL) NOPASSWD: ALL

One liner action:

    sudo sh -c "echo '$(id -un) ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"

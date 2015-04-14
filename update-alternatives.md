# update-alternatives

# /etc/alternatives

Utility that manages which version of executables is going to be run through symlinks.

For example Ubuntu 14.04 comes with

    which editor

as `/usr/bin/editor`, and:

    readlink `which editor`

Gives:

    /etc/alternatives/editor

And:

    readlink /etc/alternatives/editor

Points to:

    /usr/bin/vi

In this way, all preferences are stored under `etc` as specified by the LSB.

The `update-alternatives` utility can be used to manage that system.

For example, to configure the default browser use:

    sudo update-alternatives --config x-www-browser

This will show the possibilities (TODO how does he know?) for you to choose from them.

Important alternatives include:

- `editor`: text editor
- `x-www-browser`: web browser

TODO: understand the following command:

    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50

- `50`: priority of the alternative. Metadata associated by `update-alternatives`. Alternative with greatest priority wins.

I used this to link `gcc` to `gcc-4.8` instead of `4.6`.

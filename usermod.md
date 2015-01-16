# usermod

shadow-utils package.

Add or remove users to groups.

If you are the user, you have to logout/login again for changes to take effect.

Change primary group of user `u` to `g`:

    g=1000
    sudo usermod -g "$g" "$u"

Sets exactly the supplementary groups of user `u`. Remove from non listed ones:

    sudo usermod -G "$g" "$u"

Append (-a) groups `g` to supplementary groups of user `u`:

    sudo usermod -aG "$g" "$u"

Change home directory of user `u` to `d`. The old contents are not moved:

    sudo usermod -d "$d" "$u"

Also move home directory contents to the new home:

    sudo usermod -md "$d" "$u"

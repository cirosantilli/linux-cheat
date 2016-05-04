# dconf

DConf is the new backend for gsettings.

It used in Ubuntu 15.10 to store many desktop settings. `unity-control-center` is basically a front-end for it, and many default applications store their settings there.

Completely separate schema to gconf.

It should be used on new apps instead of gconf.

## ~/.config/dconf/user

File that stores all dconf settings.

Binary database format, which implies:

- fast to parse. Specially important as startup
- not human readable. But you can export and import plain-text `.conf` file representations with `dconf dump` and `dconf load`.
- corruption of part of it can kill all the data in one go.
- not portable across OSes. Would be a good choice for apps if not for this.

## dconf utility

View all dconf configs at once in plain-text:

    dconf dump / >~/.config/dconf/user.conf

Reload plain-text settings:

    dconf load / <~/.config/dconf/user.conf

Change one setting:

    dconf write org/gnome/gnome-screenshot/auto-save-directory "/home/ciro"

Print to stdout whenever a setting changes:

    dconf watch /

So when you use some GUI to change things, you know what is going on.

## dconf-editor

GUI editor for dconf

    dconf-editor

## gsettings

gsettings is a frontend for both dconf on Linux, and possibly other backends on other systems such as the Windows registry (binary).

Therefore, applications should only use it directly, and not dconf, to achieve greater portability.

On current GNOME based desktops, it does not support GConf.

Set the value of a key:

    gsettings set 'org.gnome.gnome-screenshot' 'auto-save-directory' 'file:///home/$USER/screenshot'

Normal not hidden scroll bars:

    gsettings set com.canonical.desktop.interface scrollbar-mode normal

Show username on panel:

    gsettings set com.canonical.indicator.session show-real-name-on-panel true

Return key to its default value:

    gsettings reset com.canonical.desktop.interface scrollbar-mode

## dconf vs gconf vs gsettings

Applications can them to manage user preferences. in key/value manner, where keys are put in a `/` separated tree.

Created by the gnome project.

Sources:

- <http://askubuntu.com/questions/22313/what-is-dconf-what-is-its-function-and-how-do-i-use-it>
- <http://askubuntu.com/questions/249887/gconf-dconf-gsettings-and-the-relationship-between-them>
- gconf vs dconf: <http://askubuntu.com/questions/34490/what-are-the-differences-between-gconf-and-dconf>

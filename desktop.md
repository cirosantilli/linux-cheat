# Desktop

Info on freedesktop.org, the X Window System, Display managers, desktop environments like GNOME, KDE, and closely related utilities such as `xsel`, `wmctrl` or `recordmydesktop`.

## xdg-settings

    xdg-settings --list

TODO why does it show a single line only? what should this list?

## screenshots

Tools include:

- GNOME screenshot
- `xwd`
- recordMyDesktop

### GNOME screenshot

Ubuntu 12.04 default on `PrtSc` key.

Change directory where images are saved:

    gsettings set "org.gnome.gnome-screenshot" "auto-save-directory" "file:///home/$USER/screenshot"

Default shortcuts on Ubuntu 12.04:

- `PrtSc`: take screenshot of entire screen
- `Alt` + `PrtSc`: take screenshot of current window, the menu including bar. `gnome-screenshot -w`.
- `Shirt` + `PrtSc`: start a crosshair cursor and take screenshot of a given selection. `gnome-screenshot -a`.

Useful options:

- remove menu bar: `wB`

## Desktop environment

Includes a many components, such as:

- default user apps like text editors, browser, etc.
- window manager
- panel

For a concrete example see: <http://lxde.org/lxde>

Most of those can be changed for others, but the applications of a given DE usually play well together.

A great way to view how those components interact is via `pstree`. The following example was created using:

- `Xorg` X server
- `lightdm` DM
- `lxsession` session manager
- `openbox` window manager
- `firefox` was started from Openbox run (analogous to Ubuntu dash)
- `xterm` was started via autostart TODO put it there

The abridged output looks like:

    init-+
         |-lightdm-+-Xorg---2*[{Xorg}]
         |         |-lightdm-+-lxsession-+-lxpanel---2*[{lxpanel}]
         |         |         |           |-openbox
         |         |         |           |-xscreensaver
         |         |         |           ...
         |         |         |           `-3*[{lxsession}]
         |         |         `-{lightdm}
         |         `-2*[{lightdm}]
         |-firefox
         ...

Other sessions may use different spawn strategies.

So notice a few interesting facts:

-   `lightdm` comes first and spawns `Xorg` and `lxsession`

-   `lxsession` spawns all the other desktop components, such as:

    - the `openbox` window manager
    - the `xcreensaver` window manager

-   `firefox` is a direct child of init. Therefore `lxpanel` must have re-parented it to `init`, so that it can keep running even if `lxpanel` is killed or restarted.

Gnome 3 spawn tree (xterm launched via the dash) looks like:

    init-+
         |-lightdm-+-Xorg---2*[{Xorg}]
         |         |-lightdm-+-gnome-session-+-deja-dup-monito---2*[{deja-dup-monito}]
         |         |         |               |-firefox---35*[{firefox}]
         |         |         |               |-gnome-shell-+-gnome-screensav---2*[{gnome-screensav}]
         |         |         |               |             |-xterm---bash
         |         |         |               ...
         ...

KDE spawn tree:


    init-+
         |-kdeinit4-+-deja-dup-monito---2*[{deja-dup-monito}]
         |          |-firefox---33*[{firefox}]
         |          |-xterm---bash
         |          ...
         |-lightdm-+-Xorg---2*[{Xorg}]
         |         |-lightdm-+-startkde-+-kwrapper4
         |         |         |          `-ssh-agent
         |         |         `-{lightdm}
         ...

### GNOME

GNOME 3 is the default DE for Fedora.

The GNOME project maintains GTK and many desktop software components.

Default window manager: `mutter`

Default session manager: `gnome-session`

Integrated control panel frontend: `gnome-control-center`.

Acts as a large frontend for several things such as printers, screen, etc., much like Window > Start > System.

Good way to manage GTK themes and other GNOME things: `gnome-tweak-tool`.

### Unity

Default DE for Ubuntu 12.04+.

#### Unity window manager

Default window manager: Ubuntu 13.04 ships with 2 Compiz *and* Metacity, the choice depends on your hardware support: <http://askubuntu.com/questions/24977/why-does-ubuntu-use-two-window-managers-compiz-and-metacity>

Most modern laptops have enough hardware for Compiz.

You can decide which one is use via:

    ps -A | grep -e compiz -e metacity

#### Unity panel

Named: unity-panel-service.

An important part of Unity (basically the only distinctive feature of most DEs)

#### Unity utility

Restart the unity shell only, less effective and drastic than restarting LightDM:

    unity --restart

#### Applets

##### Alarm clock applet

Notifies you with sounds when a certain time passed.

##### weather indicator

### KDE

Default DE for the KDE distro.

Uses Qt toolkit instead of GTK.

GNOME and KDE rivalry started when KDE chose to use QT in 1998 which was not GPL source for non-X11 platforms.

As of Qt 4, LGPL versions of Qt exist on all platforms, but the damage has been done: the open source community is divided and maintain duplicate versions for many desktop software, thus using up resources.

#### KDE command line options

KDE has a great level of uniformity across its programs, and all of them get standard KDE command line options.

Some useful options are:

-   `--caption asdfqwer`: set the caption for the window.

    E.g., if without this option you would get: `filename.pdf - Okular` on the window title, with the option it becomes `filename.pdf - asdfqwer`. This is useful to reference the application from another program like `wmctrl -a asdfqwer`.

#### Applications

KDE offers both basic building blocks, and full applications.

The software offered is called the [KDE Software Compilation](http://www.kde.org/community/whatiskde/softwarecompilation.php).

KDESC applications release at the same time as new KDE versions. For example, Okular ships a specific release with every new KDE base version, and its git tags are exactly KDE versions.

There are also projects which use KDE, but which are not part of the KDESC.

#### Libraries

A typical KDE application relies on the following shared libraries:

    libkparts.so.4
    libkio.so.5
    libkdeui.so.5
    libQtGui.so.4
    libkdecore.so.5
    libQtCore.so.4
    libQtDBus.so.4

#### kde4-config

Get information on KDE configuration on current system.

Installation prefix:

    kde4-config --prefix

The value is usually `/usr`

This means for example that there will be many shared object files under `/usr/lib/kde4/`, and that the installed executables will go under `/usr/bin`.

### LXDE

Default DE for Arch Linux.

Very lightweight and fast. Really makes programs open, close and change tabs and sub-windows faster.

Follows `freedesktop.org` standards.

Default window manager: Openbox.

For keyboard shortcuts, see info on Openbox.

Configuration files:

Choose GTK themes with:

    lxappearance

Choose Qt themes with:

    qtconfig-qt4

Sources:

-   <http://lxde.org/lxde>

    Official website.

    Good to see what it is made up of.

-   <https://wiki.archlinux.org/index.php/LXDE>

    Arch Linux wiki.

    Default DE for Arch Linux, so lots of info there.

#### keyboard layout

<http://www.pclinuxos.com/forum/index.php?topic=87702.0>

Right click on panel and add the Keyboard Layout Handler to the panel.

Right click on the Keyboard layout manager and choose your settings.

TODO what are the available layouts? What are the config files?

## session manager

TODO

## toolkits

Although there is a X11 C interface, consider using higher level, more portable and more convenient interfaces such as:

### Qt

Used mainly by KDE.

It is so associated with KDE that some settings are found under the kde configuration folders.

Themes locations:

- `/usr/share/kde4/apps/color-schemes`
- `~/.kde/share/apps/color-schemes`

Customize qt with GUI:

    qtconfig-qt4

You can change themes there.

If you choose the GTK+ theme, it will use your GTK theme.

Most KDE applications have a command line qt interface part, and you can get the qt version, together with the KDE version required by doing using `-v`, for example:

    krusader -v

which produces output like:

    Qt: 4.8.4
    KDE Development Platform: 4.10.4
    Krusader: 2.4.0-beta1 "Migration

### GTK

3 versions: 1, 2 and 3.

Configuration files for 2.0:

    ~/.gtkrc-2.0

Configuration syntax for 2.0:

    gtk-theme-name = "Clearlooks"

Configuration files for 3.0:

    $XDG_CONFIG_HOME/gtk-3.0/settings.ini

Configuration syntax for 3.0:

    [Settings]

        gtk-icon-theme-name = <icon-theme-name>

        gtk-theme-name = <gtk-3-theme-name>

        style "schrift"
        {
            font_name = "DejaVu Sans 10"
        }
        widget_class "*" style "schrift"
        gtk-font-name = "DejaVu Sans 10"

        gtk-toolbar-style   = GTK_TOOLBAR_ICONS              #Only icons
        gtk-toolbar-style   = GTK_TOOLBAR_TEXT	             #Only text
        gtk-toolbar-style   = GTK_TOOLBAR_BOTH	             #Both icons and text
        gtk-toolbar-style   = GTK_TOOLBAR_BOTH_HORIZ	     #Icons and text next to the icons

Very nice demo of lots of 2.0 features with easy to see source code side by side:

    gtk-demo

### TODO how to find if an application uses GTK and which version

It is not generally possible to do so.

If the program uses GTK as a dynamic library, you can try:

    ldd /bin/ls

However some programs seem to use GTK as a static library.

Sometimes, programs also give GTK specific options from the command line.

---

TODO where is GTK configuration stored?

You can install new GTK themes by placing their files under TODO.

Note however that it is more recommended that you get themes from packages, so that those can get automatically updated.

## Themes

Control how the system looks.

Theme folders:

- `/usr/share/themes/`
- `~/.themes/`

Those folders contain themes for GTK and window managers.

Each directory structure is like:

- `/usr/share/themes/theme-name/gtk-2.0`
- `/usr/share/themes/theme-name/openbox-3.0`

TODO where are Qt themes stored?

## Panels

Like windows GUI item that contains the start menu.

Typically offer:

- a way to launch programs so that users can: type any part in the middle and click on the auto completed desired match
- contain a list of all windows so that users can point click to open a window
- contain a list of programs so that users can click to open the programs
- holds applets: small icons that offer interface for processes which users don't want to have a window, such as clock, logout/shutdown GUI, Internet connection.

Panels are X clients.

### LXPanel

LXDE default.

Configuration files: `.config/lxpanel/LXDE/`

## power

### shutdown

Sends TODO signal to running processes and waits for them to terminate nicely:

    sudo shutdown -P now

### reboot

    sudo reboot

### suspend and hibernate

Sources:

- <https://help.ubuntu.com/community/PowerManagement/Overview>
- <http://askubuntu.com/questions/1792/how-can-i-suspend-hibernate-from-command-line>

Both can be done with `pmi`, `pm-utils` or `dbus-send`

#### suspend

Keeps things on RAM, but pauses all processes that can be paused, and turns off screen.

You need to use a bit of power to keep it suspended.

#### hibernate

Save RAM to disk, shuts down almost everything.

Uses very little to no power.

TODO pmi vs pm-utils?

### ACPI

TODO

### pm-utils package

Maintained by freedesktop.org: <http://pm-utils.freedesktop.org/wiki/>

Mnemonic: Power Management.

    pm-suspend
    pm-hibernate

### pmi

    pmi action suspend
    pmi action hibernate

## Lock screen

State in which user must enter a password to be able to do or see anything.

Does not necessarily suspend computer for power saving.

Usually fires up the screensaver.

## D-Bus

IPC library and daemon.

Specified by freedesktop.org: <http://www.freedesktop.org/wiki/Software/dbus/>

Main method used for IPC in KDE 4 and GNOME.

### dbus-monitor

View D-Bus messages as they are sent.

### dbus-send

Suspend computer:

    dbus-send --system --print-reply \
        --dest="org.freedesktop.UPower" \
        /org/freedesktop/UPower \
        org.freedesktop.UPower.Suspend

### libdbus

Library that allows application to communicate with D-Bus.

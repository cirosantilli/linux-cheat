#standards

##freedesktop.org

aka XDG (freedesktop.org was formerly known as the X Desktop Group,
and the acronym "XDG", remains common in their work.)

http://www.freedesktop.org/wiki/

Specifies:

- autostart

- <http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html>

    basedir spec

    Specifies where configuration and data files should be put,
    and enviroment variables that indicate that place such as `$XDG_CONFIG_HOME`

    All enviroment variables have a default value to be assumed in case they are not present.

    - `$XDG_CONFIG_HOME`: base location of per-user configuration files. Default value: `.config`.

    - `$XDG_CONFIG_DIRS`: comma separated list of where to look for cross user configuration files.

        Default value: `/etc/xdg`

- `echo $XDG_CURRENT_DESKTOP`: current DE in use.

    Gnome 3 output: GNOME

Also check the `man xdg-` tools. Not sure how much they have been adopted however.

#x11

Real name: X Window System

x11 is a `window system`

It is by far the most commonly used on Linux.

An upcoming alternative is Wayland. It is not yet widely used,
but plans made for use in Ubuntu.

x11 is only an interface.

There can be different implementations:

- X.org implentation currently dominates
- XFree86 was the dominant prior to 2004,
    when it adopted BSD license leaving GPL, and fell into oblivion.

X is an abstraction layer for things like:

- windows
- key presses
- mouse position / presses
- screen backlight

X does not:

- relegates certain jobs to x display managers and x window managers.

- panel

- a desktop that shows files contained in some predefined folder. TODO who does that?

- sound management

    this has been taken up by other projects:

    - PulseAudio
    - Advanced Linux Sound Architecture (ALSA)

Usually graphic accelerated. This is why messing with gpu settings may break your desktop.

X11 uses a server/client mode

Client and server can be on different machines

Client:

- typically programs with a window
- clients give commands to the xserver and tell it to draw on screen
- clients respond to input events via callback functions

Server:

- creates the image

- sends inputs events to clients who responds to it via callbacks

- a server has many displays

- a display has many screens, one mouse and one keyboard

- to set the display to use use the DISPLAY var:

        env DISPLAY=localhost:0.1 firefox & #single commena

    Display notation: `0.1` means: display 0, screen 1

A good way to see some basic and useful application implemented in pure X as demos
is to do `ls /etc/X11/app-defaults`

##xorg

Dominant implementation of the X server.

Conf file:

    man xorg.conf

First of:

- /etc/X11/<cmdline>
- /tmp/Xorg-KEM/etc/X11/<cmdline>
- /etc/X11/$XORGCONFIG
- /tmp/Xorg-KEM/etc/X11/$XORGCONFIG
- /etc/X11/xorg.conf-4
- /etc/X11/xorg.conf
- /etc/xorg.conf

where <cmdline> is specified on the command line at startup

Log file

    less /var/log/Xorg.0.log

where `0` is the display number.

##X

Get xserver version

    sudo X -version

##xhost

TODO

##startx

TODO

##xlsclients

List x clients.

This allows you to see all open windows.

	xlsclients

More detailed info:

	xlsclients -l

##xprop

Get window info on a window

	xprop -name Krusader
	xprop -id 0x2000001

Keep examining the properties, and print if changes happen:

	xprop -spy -name Krusader

##xmodmap

Modify key maps.

For example, to exchange exc and caps lock:

	f=~/.Xmodmap
	echo "! Swap caps lock and escape
    remove Lock = Caps_Lock
    keysym Escape = Caps_Lock
    keysym Caps_Lock = Escape
    add Lock = Caps_Lock
    " >> "$f"
	xmodmap "$f"

To make this happen every time at startup TODO broken?:

	echo "xmodmap \"$f\"
    " >> ~/.xinitrc
	chmod +x ~/.xinitrc

The `~/.xsession` file could also be used depending on system

##xdotool

Send clicks and manage window properties from sh.

###select window

Before you try to do things to a window,
you must say which window you want to act on.

If you don't give any indication, actions occur on the current window.

Every window has a window id.

Act on windows with given id:

    id=
    xdotool search --window "$id" key ctrl+c

Act on windows with given name:

    n=
    xdotool search --name "$n" key ctrl+c

Name is exactly what is shown on window titlebar.

###keystrokes

Keystroke types:

key:     up and down
keydown: only down
keyup:   only up

Send an `a` keystroke to the current window:

    xdotool key a

Send an `a` keystroke and then a `b` keystroke to the current window:

    xdotool key a b

F2:

    xdotool key F2

`á`:

    xdotool key Aacute

`ctrl+l`:

    xdotool key ctrl+l

Sends a, b, space, c and d:

    xdotool type 'ab cd'

a, waits 1 ms, b:

    xdotool type --delay 1 'ab'

###sync

Wait for application to start before sending a command to it:

    google-chrome &
    xdotool search --sync --onlyvisible --class "google-chrome"

In this way, you can launch an app and send commands, making sure they will be received!

##wmctrl

Control windows from sh (maximize, minimize, focus, etc.)

TODO

    wmctrl -m

##keyboard and mouse automation

autokey: high level, gui interface x11 automation

##xbacklight

Control screen brightness

Get current lightling level on a scale of 0 to 100:

    xbacklight -get

Set lightining to 80%:

    xbacklight -set 80

##xsel

Manipulate the x selection and clipboard

###x selection

X selection is the last focused selected text.

It can be pasted with a middle click.

It is similar to the clipboard, but is another storage area.

Set the x selection:

   echo a | xsel

Get the x selection

    assert [ `xsel` = a ]

    echo a | xsel
    echo b | xsel -a
    assert [ "`xsel`" = $'a\nb\n' ]

###x clipboard

Set and get the clipboard (control c control v access):

    echo a | xsel -b
    assert [ `xsel -b` = a ]

###follow

Follows stardard input as it grows

    echo a > f
    xsel -f < f
    assert [ "`xsel`" = $'a\n' ]
    echo b >> f
    assert [ "`xsel`" = $'a\nb\n' ]

###stop

    echo a | xsel
    echo c > f
    assert [ "`xsel`" = $'a\n' ]

##xmodmap

View and modify key mappings.

Get a list of current keymapping state:

    xmodmap -pke > ~/.Xmodmap

Sample output line:

    keycode  24 = q Q q Q adiaeresis Adiaeresis
                    ^ ^ ^ ^ ^^^^^^^^^^ ^^^^^^^^^^
                    1 2 3 4 5          6

1. no modifiers
2. shift
3. mode_switch no shift
4. mode_switch +  shift
5. ?
6. ?
7. ?
8. ?
9. ?

**AltGru** is the mode_switch key.

Up to 8 keysims bay be attached to each keycode.

However, only the first 4 are commonly used.

##setxkblayout

TODO

##simple gui apps

Either for testing or usuful utilities.

- xcalc

    Simple scientific calculations

- xgc

    X Graphics Demo.

- xeyes

    Fun x11 test program.

- xfontsel

    Point and click and view how a font looks like.

- xmag

    Magnifying lens.

- xmore

    `more`, but in X!

- xtime

    Pointer clock.

##xev

Opens test window and prints x events description to stdout:

    xterm
    xev

Try clicking on the windows, or using your keboard to see the outputs.

##xwd

Take screenshots.

Mnemonic: x11 Write Dump.

Take screenshot of all desktop:

	xwd -root -out a.xwd

Wait for mouse click and take screenshot of clicked window only:

	xwd -out a.xwd

Make a `png` screenshot:

	xwd | xwdtopnm | pnmtopng > Screenshot.png

#desktop enviroment

Includes a many components, such as:

- default user apps like text editors, browser, etc.
- window manager
- panel

For a concrete examle see: <http://lxde.org/lxde>

Most of those can be changed for others, but the applications of a given DE
usually play well together.

A great way to view how those components interact is via `pstree`.
The following exapmle was created using:

- `Xorg` X server
- `lightdm` DM
- `lxsession` session manager
- `openbox` window manager
- `firefox` was started from openbox run (analogous to ubuntu dash)
- `xterm` was started via autostart TODO put it there

The abbridged output looks like:

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

- `lightdm` comes first and spanws `Xorg` and `lxsession`

- `lxsession` spawns all the other desktop components,
    such as:

    - the `openbox` window manager
    - the `xcreensaver` window manager

- `firefox` is a direct child of init. Therefore `lxpanel` must have reparented it to `init`,
    so that it can keep running even if `lxpanel` is killed or restarted.

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

##gnome 3

Default DE for Fedora.

Default window manager: `mutter`

Default session manager: `gnome-session`

Integrated control panel: `gnome-control-center`.
Acts as a large frontend for several things such as printers, screen, etc.,
much like Window > Start > System.

##unity

Default DE for Ubuntu 12.04+.

###unity window manager

Default window manager: Ubuntu 13.04 ships with 2 compiz *and* metacity,
the choice depends on your hardware support: <http://askubuntu.com/questions/24977/why-does-ubuntu-use-two-window-managers-compiz-and-metacity>

Most modern laptops have enough hardware for compiz.

You can decide which one is use via:

    ps -A | grep -e compiz -e metacity

###unity panel

Named: unity-panel-service.

An important part of Unity (basically the only distinctive feature of most DEs)

##kde

Default DE for the KDE distro.

Uses qt toolkit instead of gtk.

##lxde

Default DE for Archlinux.

Very lightweight and fast.

Follows `freedesktop.org` standards.

Default window manager: openbox.

For keyboard shortcuts, see info on openbox.

Configuration files:

Choose gtk themes with:

    lxappearance

Choose qt themes with:

    qtconfig-qt4

Sources:

- <http://lxde.org/lxde>

    Official website.

    Good to see what it is made up of.

- <https://wiki.archlinux.org/index.php/LXDE>

    Archilinux wiki.

    Default DE for archlinux, so lots of info there.

###keyboard layout

<http://www.pclinuxos.com/forum/index.php?topic=87702.0>

Right click on panel and add the Keyboard Layout Handler to the panel.

Right click on the Keyboard layout manager and choose your settings.

TODO what are the available layouts? what are the config files?

#display manager

Shows the initial login screen where you can:

- enter your username and password
- shutdown the computer
- select which desktop environment to run (GNOME, Unity, KDE Plasma, etc.)

Some implementations:

- LightDM (lightweight), ubuntu
- KDM, kde
- GDM (gnome) fedora

Find your default X display manager:

   cat /etc/X11/default-display-manager

Log out from the grahpical tty and go back to the display manger login screen
<http://askubuntu.com/questions/180628/how-can-i-logout-from-the-gui-using-cli>:

   kill -9 -1

`man kill` tells us that here:

- `-9` is for signal number 9, SIGKILL
- `-1` is a special number, which means all pids except for init and the kill process itself.

##lightdm

Default display manager for Ubuntu.

###sources

- <https://wiki.ubuntu.com/LightDM>

   ubuntu docs

---

Desktop chosen on last login:

   echo $GDMSESSION

Configuration file:

   less /etc/lightdm/lightdm.conf

Don't edit the configuration file directly, use this instead:

   sudo /usr/lib/lightdm/lightdm-set-defaults --hide-users true

Options:

- hide-users: don't show user list to select from.

   #Prevent users from disovering the names of all users on the system.

- allow-guest:

- autologin-user username: autologin the given user

- display-setup-script=[script|command]

Restart lightdm:

    sudo restart lightdm

Also restarts X. Closes all your programs that have windows.

Only do this on a tty, not on an xterminal probably because
your terminal is going to die in the middle of the operation

	sudo stop lightdm
	sudo start lightdm

#window manager

An X window manager interacts with X to do things like:

- window switching (alt tab / visible list of open windows)

- maximize, minimize, fullscreen

- multiple desktops functionality

- the title bar, including the application's icon,
    the buttons to minimize, maximize, close, and what happens on drag (move window)
    or right click (show window options)

Window managers are X Clients.

It does not take care of:

- panel
- desktop
- what happens inside windows (this is usually managed with a toolkit like gtk or qt)

Implementations:

- metacity
- compiz

##openbox

Default for archlinux

Minimalistic

Very fast.

Graphical configuration tool

    obconf

you can change themes there, but not all config options are modifiable from there.

Configuration file:

    ~/.config/openbox/lxde-rc.xml

Configure keyboard shortcuts in the config file:

    keyboard > keybind

Possible actions are listed here: <http://openbox.org/wiki/Help:Actions>

An useful example is to half maximize a windows with Win + Left/Right

    <keybind key="W-Left">
        <action name="Unmaximize"/>
        <action name="Maximize">
            <direction>vertical</direction>
        </action>
        <action name="MoveResizeTo">
            <x>0</x>
            <y>0</y>
            <width>50%</width>
        </action>
    </keybind>

    <keybind key="W-Right">
        <action name="Unmaximize"/>
        <action name="Maximize">
            <direction>vertical</direction>
        </action>
        <action name="MoveResizeTo">
            <x>-0</x>
            <y>0</y>
            <width>50%</width>
        </action>
    </keybind>

For the right, the minus sight `-` indicates that the distance
is between the right edge of the window and the right screen edge.

Restart after changing config file to take changes into consideration:

    openbox --restart

##mutter

##compiz

Passes window decoration to a compiz window decorator.

Some compiz window decorators:

- gtk-window-decorator: uses gtk for window decoration
- emerald:

Configurations: `gconf-editor` under `apps.compiz-1`.

Restart compiz after modifying configurations to load them:

    compiz --replace

You should do this from a tty other than tty7.

#session manager

TODO

#startup programs

User space startup programs can only start after the display manager has logged the use in.

Therefore, they must either be launched by the DM at the end of its opertion, or by something spawned by it.

##autostart

Used by Ubuntu, LXDE, KDE, GNOME

Specification by freedesktop.org: <http://standards.freedesktop.org/autostart-spec/autostart-spec-latest.html>

Configuration files under:

- `/etc/xdg/autostart`
- `~/.config/autostart/`.

Each file gets sourced.

Example, in a file called `firefox`, put:

[Desktop Entry]
    Type=Application
    Exec=firefox

TODO who executable implements it? which DEs adopt it?

#toolkits

Although there is a X11 c interface, consider using higher level,
more portable and more convenient interfaces such as:

##qt

Used mainly by KDE.

It is so associated with KDE that some settings are found under the kde configuration folders.

Themes locations:

- `/usr/share/kde4/apps/color-schemes`
- `~/.kde/share/apps/color-schemes`

Customize qt with GUI:

   qtconfig-qt4

You can change themes there.

If you choose the gtk+ theme, it will use your gtk theme.

Most kde appliations have a command line qt interface part,
and you can get the qt version, together with the KDE version required
by doing using `-v`, for example:

    krusader -v

which produces output like:

    Qt: 4.8.4
    KDE Development Platform: 4.10.4
    Krusader: 2.4.0-beta1 "Migration

##gtk

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

##TODO how to find if an application uses gtk and which version

It is not generally possible to do so.

If the program uses gtk as a dynamic library, you can try:

    ldd /bin/ls

However some programs seem to use gtk as a static library.

Sometimes, programs also give gtk specific options from the command line.

---
TODO where is gtk configuration stored?

You can install new gtk themes by placing their files under TODO.

Note however that it is more recommended that you get themes from packages,
so that those can get automatically updated.

#themes

Control how the system looks.

Theme folders:

- `/usr/share/themes/`
- `~/.themes/`

Those folders contain themes for gtk and window managers.

Each dire structure is like:

    - `/usr/share/themes/theme-name/gtk-2.0`
    - `/usr/share/themes/theme-name/openbox-3.0`

Todo: where are qt themes stored?

#panels

Like windows GUI item that contains the start menu.

Typically offer:

- a way to launch programs so that users can:

    - type any part in the middle and click on the desired match
    - 

- contain a list of all windows so that users can point click to open a window

- contain a list of programs so that users can click to open the programs

- holds applets: small icons that offer interface for processes which users don't want to have a window,
    such as clock, logout/shutdown gui, internet connection.

Panels are X clients.

##lxpanel

LXDE default.

Config files: `.config/lxpanel/LXDE/`

##dconf gconf gsettings

Applications can them to manage user preferences.
in key/value manner, where keys are put in a `/` separated tree.

Created by the gnome project.

Sources:

- <http://askubuntu.com/questions/22313/what-is-dconf-what-is-its-function-and-how-do-i-use-it>
- <http://askubuntu.com/questions/249887/gconf-dconf-gsettings-and-the-relationship-between-them>
- gconf vs dconf: <http://askubuntu.com/questions/34490/what-are-the-differences-between-gconf-and-dconf>

###dconf

dconf is a the new backend for gsettings.

It is also the name of a cli utility used to view and edit dconf settings.

Completelly separate schema to gconf.

It should be used on new apps instead of gconf.

It is binary. This implies that:

- fast to parse. Specially important as startup.
- not human readable.
- corruption of part of it can kill all the data in one go.
- binary config file located at: `~/.config/dconf/user`

View all dconf configs at once:

    dconf dump / | less

Here you see a reverse url dot notation:

    org.gnome.metacity

GUI editor: `dconf-editor`

###gconf

xml based

Older than dconf.

Each config tree is implemented as actual directories with files at the nodes.

Config files: `~/.gconf/`

CLI view / edit tool: `gconftool-2`

Get all the xlm confs:

    gconftool --dump / | less

GUI editor: `gconf-editor`

##gsettings

gsettings is a frontend for both dconf on Linux,
and possibly other backends on other systems such as the Windows registry (binary).

Therefore, applications should only use it, and not dconf to have greater portability.

On current gnome based desktops it is not a frontend for gconf.

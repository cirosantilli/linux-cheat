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

- panel ( like Windows start menu or Ubuntu dash ) used to launch programs.

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

#xorg

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

#X

Get xserver version

    sudo X -version

#xhost

TODO

#startx

TODO

##xlsclients

List x clients.

This allows you to see all open windows.

	xlsclients

More detailed info:

	xlsclients -l

#xprop

Get window info on a window

	xprop -name Krusader
	xprop -id 0x2000001

Keep examining the properties, and print if changes happen:

	xprop -spy -name Krusader

#xmodmap

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

#xdotool

Send clicks and manage window properties from sh.

##select window

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

##keystrokes

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

##sync

Wait for application to start before sending a command to it:

    google-chrome &
    xdotool search --sync --onlyvisible --class "google-chrome"

In this way, you can launch an app and send commands, making sure they will be received!

#wmctrl

Control windows from sh (maximize, minimize, focus, etc.)

TODO

    wmctrl -m

## keyboard and mouse automation

autokey: high level, gui interface x11 automation

#xbacklight

Control screen brightness

Get current lightling level on a scale of 0 to 100:

    xbacklight -get

Set lightining to 80%:

    xbacklight -set 80

#xsel

Manipulate the x selection and clipboard

##x selection

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

##x clipboard

Set and get the clipboard (control c control v access):

    echo a | xsel -b
    assert [ `xsel -b` = a ]

##follow

Follows stardard input as it grows

    echo a > f
    xsel -f < f
    assert [ "`xsel`" = $'a\n' ]
    echo b >> f
    assert [ "`xsel`" = $'a\nb\n' ]

##stop

    echo a | xsel
    echo c > f
    assert [ "`xsel`" = $'a\n' ]

#xmodmap

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

#xeyes

Fun x11 test program.

    xeyes

#xev

Opens test window and prints x events description to stdout:

    xterm
    xev

Try clicking on the windows, or using your keboard to see the outputs.

#xwd

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

So notice a few interesting facts:

- `lightdm` comes first and spanws `Xorg` and `lxsession`

- `lxsession` spawns all the other desktop components,
    such as:

    - the `openbox` window manager
    - the `xcreensaver` window manager

- `firefox` is a direct child of init. Therefore `lxpanel` must have reparented it to `init`,
    so that it can keep running even if `lxpanel` is killed or restarted.

##lxde

###sources lxde

- <http://lxde.org/lxde>

    Official website.

    Good to see what it is made up of.

- <https://wiki.archlinux.org/index.php/LXDE>

    Archilinux wiki.

    Default DE for archlinux, so lots of info there.

Archlinux default.

Very lightweight and fast.

Default window manager: openbox.

Choose gtk themes with:

    lxappearance

Customize keyboard shortcuts with:

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

   #ubuntu docs

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

It does not take care of:

- panel
- desktop
- what happens inside windows (this is usually managed with a toolkit like gtk or qt)

Implementations:

- metacity: ubuntu
- compiz: gnome

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

#session manager

TODO

#toolkits

Although there is a X11 c interface, consider using higher level,
more portable and more convenient interfaces such as:

##qt

Customize qt with GUI:

   qtconfig-qt4

You can change themes there.

Most kde appliations have a command line qt interface part,
and you can get the qt version, together with the KDE version required
by doing using `-v`, for example:

    krusader -v

which produces output like:

    Qt: 4.8.4
    KDE Development Platform: 4.10.4
    Krusader: 2.4.0-beta1 "Migration

##gtk

Very nice demo of lots of 2.0 features with easy to see source code side by side:

    gtk-demo

TODO how to find if an application uses gtk and which version
TODO where is gtk configuration stored?

You can install new gtk themes by placing their files under TODO.

Note however that it is more recommended that you get themes from packages,
so that those can get automatically updated.

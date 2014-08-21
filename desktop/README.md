Info on freedesktop.org, the X Window System, Display managers, desktop environments like GNOME, KDE, and closely related utilities such as `xsel`, `wmctrl` or `recordmydesktop`.

#XDG

See freedesktop.org.

#freedesktop.org

AKA XDG because freedesktop.org was formerly known as the X Desktop Group, and the acronym "XDG" remains common in their work.

Large community website, de facto standard on certain areas, use its software and follow its standards if you can.

Generally followed by both GNOME and KDE for example.

Contains both standard specifications, and also hosts software projects.

<http://www.freedesktop.org/wiki/>

Hosts standard specifications and software projects.

Specifies:

-   autostart

-   `echo $XDG_CURRENT_DESKTOP`: current DE in use.

    Gnome 3 output: GNOME

##xdg-utils

<http://portland.freedesktop.org/xdg-utils-1.0/>.

A few useful applications that should be standard.

Adopted by the LSB 4.1.

##Base directory spec

<http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html>

Specifies where configuration and data files should be put, and environment variables that indicate that place such as `$XDG_CONFIG_HOME`

All environment variables have a default value to be assumed in case they are not present.

###XDG_CONFIG_HOME

Base location of per-user configuration files. Default value: `.config`.

###XDG_CONFIG_DIRS

Comma separated list of where to look for cross user configuration files.

Default value: `/etc/xdg`

###XDG_DATA_HOME

Data instead of configurations. Default: `.local`.

###XDG_DATA_DIRS

Data instead of configurations. Default: `/usr/local/share/:/usr/share/`.

###XDG_DATA_DIRS

###XDG_CACHE_HOME

Temporary data. Default: `~/.cache`. Can get rather large, and since the standard says that "non-essential data files should be stored" there, it should be fine to delete it.

#xdg-settings

    xdg-settings --list

TODO why does it show a single line only? what should this list?

#X11

Real name: X Window System

X11 is a `window system`

It is by far the most commonly used on Linux.

An upcoming alternative is Wayland. It is not yet widely used,
but plans made for use in Ubuntu.

X11 is only an interface.

There can be different implementations:

- X.org implementation currently dominates
- XFree86 was the dominant prior to 2004,
    when it adopted BSD license leaving GPL, and fell into oblivion.

X is an abstraction layer for things like:

- windows
- key presses
- mouse position / presses
- screen backlight

X does not:

-   relegates certain jobs to x display managers and x window managers.

-   panel

-   a desktop that shows files contained in some predefined folder. TODO who does that?

-   sound management

    This has been taken up by other projects:

    - PulseAudio
    - Advanced Linux Sound Architecture (ALSA)

Usually graphic accelerated. This is why messing with GPU settings may break your desktop.

X11 uses a server/client mode

Client and server can be on different machines

Client:

- typically programs with a window
- clients give commands to the X server and tell it to draw on screen
- clients respond to input events via callback functions

Server:

-   creates the image

-   sends inputs events to clients who responds to it via callbacks

-   a server has many displays

-   a display has many screens, one mouse and one keyboard

-   to set the display to use use the DISPLAY var:

        env DISPLAY=localhost:0.1 firefox & #single commena

    Display notation: `0.1` means: display 0, screen 1

A good way to see some basic and useful application implemented in pure X as demos
is to do `ls /etc/X11/app-defaults`

##xorg

Dominant implementation of the X server.

Configuration file:

    man xorg.conf

First of:

- `/etc/X11/<cmdline>`
- `/tmp/Xorg-KEM/etc/X11/<cmdline>`
- `/etc/X11/$XORGCONFIG`
- `/tmp/Xorg-KEM/etc/X11/$XORGCONFIG`
- `/etc/X11/xorg.conf-4`
- `/etc/X11/xorg.conf`
- `/etc/xorg.conf`

where `<cmdline>` is specified on the command line at startup

Log file:

    less /var/log/Xorg.0.log

where `0` is the display number.

##X

Get X server version

    sudo X -version

##xhost

View and edit on which users may connect to an X server.

When you start with most desktop environments, they start the host as you.

If you `su another-user`, by default he cannot connect.

View current status:

    xhost

Let any user connect:

    xhost +

Let a single user connect:

    xhost + another-user

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

Name is exactly what is shown on window title bar.

###keystrokes

Keystroke types:

- key:     up and down
- keydown: only down
- keyup:   only up

Send an `a` keystroke to the current window:

    xdotool key a

Send an `a` keystroke and then a `b` keystroke to the current window:

    xdotool key a b

`F2`:

    xdotool key F2

`á`:

    xdotool key Aacute

`ctrl+l`:

    xdotool key ctrl+l

Sends `a`, `b`, `space`, `c` and `d`:

    xdotool type 'ab cd'

`a`, waits 1 ms, `b`:

    xdotool type --delay 1 'ab'

###sync

Wait for application to start before sending a command to it:

    google-chrome &
    xdotool search --sync --onlyvisible --class "google-chrome"x-terminal-emulator

In this way, you can launch an app and send commands, making sure they will be received!

##wmctrl

Control windows and get info on them from sh (maximize, minimize, focus, etc.)

Depends on the presence of a window manager.

Very good tutorial: <http://spiralofhope.com/wmctrl-examples.html>

Get info:

- `-d`: desktop info
- `-m`: window manager info

###window choice

In order to act on a window, one must first select it. The ways to do it are:

-   default (no special option): case insensitive title substring match.

    In case of multiple matches, the first one is chosen.

    E.g.:

        wmctrl -a '- mozilla firefox'

    Will act on a window with title:

        'Google - Mozilla Firefox'

-   `-F`: case sensitive title substring match.

    E.g.:

        wmctrl -Fa '- Mozilla Firefox'

    Will act on a window with title:

        'Google - Mozilla Firefox'

    But not on a window with title:

        'Google - mozilla firefox'

###actions

Once a window is selected, actions can be done on it.

Go to desktop of given window, bring it forward and maximize it:

    wmctrl -a '- mozilla firefox'

Mnemonic: Activate.

Close window:

    wmctrl -c '- mozilla firefox'

Resize and reposition window:

    wmctrl -r '- mozilla firefox' -e 1,0,0,800,600
                                     1 2 3 4   5

`-r` selects the window for commands that already take other arguments such as `-e`

- `1`: gravity TODO
- `2` and `3`: position.
- `4` and `5`: size.

If the window is maximized, this does nothing.

Switch to desktop 1:

    wmctrl -s 1

##keyboard and mouse automation

###AutoKey

High level, GUI interface X11 automation.

##xbacklight

Control screen brightness

Get current lightning level on a scale of 0 to 100:

    xbacklight -get

Set lightning to 80%:

    xbacklight -set 80

##xrandr

Acronym for X Resize, rotate AND Reflect

Gets and sets screen properties such as screen resolution.

    xrandr

Sample output:

    Screen 0: minimum 320 x 200, current 1600 x 900, maximum 32767 x 32767
    LVDS1 connected primary 1600x900+0+0 (normal left inverted right x axis y axis) 309mm x 174mm
       1600x900       60.0*+   40.0
       1440x900       59.9
       1360x768       59.8     60.0
       1152x864       60.0
       1024x768       60.0
       800x600        60.3     56.2
       640x480        59.9
    VGA1 disconnected (normal left inverted right x axis y axis)
    VIRTUAL1 disconnected (normal left inverted right x axis y axis)
    LVDS-2 disconnected (normal left inverted right x axis y axis)
    VGA-2 disconnected (normal left inverted right x axis y axis)
    DP-1 disconnected (normal left inverted right x axis y axis)
    DP-2 disconnected (normal left inverted right x axis y axis)
    DP-3 disconnected (normal left inverted right x axis y axis)

TODO understand everything on this output.

This output lists the possible resolutions. Mine are: `1600x900` (current because of the `*`, default because of the `+`).

Change resolution:

    xrandr -s 1360x769

the new resolution must be on the list.

Now:

    xrandr

Outputs:

    1600x900       60.0 +   40.0
    1440x900       59.9
    1360x768       59.8*    60.0
    1152x864       60.0
    1024x768       60.0
    800x600        60.3     56.2
    640x480        59.9

So the asterisk `*` gives the new resolution.

Change to default resolution (the one with the plus sign `+`):

    xrandr -s 0

##PRIMARY selection

##CLIPBOARD

##selection

X support an arbitrary number of selections.

The most important ones are widely implemented by default by most GUI systems:

-   `PRIMARY`: automatically updated to the last selected text.

    It can be pasted with a middle click.

-   `CLIPBOARD`: Ctrl + C, Ctrl + V mechanism.

Each selection contains data completely separate from the others.

Those concepts touched by freedesktop.org: <http://freedesktop.org/wiki/Specifications/ClipboardsWiki/>

##xsel

Manipulate the x selection and clipboard

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

Follows standard input as it grows

    echo a > f
    xsel -f < f
    assert [ "`xsel`" = $'a\n' ]
    echo b >> f
    assert [ "`xsel`" = $'a\nb\n' ]

###stop

    echo a | xsel
    echo c > f
    assert [ "`xsel`" = $'a\n' ]

##xclip

Alternative tool to `xsel`.

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

Up to 8 keysyms bay be attached to each keycode.

However, only the first 4 are commonly used.

##setxkblayout

TODO

##setxkbmap

Swap ESC and CapsLock:

    setxkbmap -option caps:escape

Put this in your `~/.xinitrc`.

##Simple GUI apps

Either for testing or useful utilities.

-   `xcalc`

    Simple scientific calculations

-   `xgc`

    X Graphics Demo.

-   `xeyes`

    Fun X11 test program.

-   `xfontsel`

    Point and click and view how a font looks like.

-   `xmag`

    Magnifying lens.

-   `xmore`

    `more`, but in X!

-   `xtime`

    Pointer clock.

##xev

Opens test window and prints x events description to stdout:

    xterm
    xev

Try clicking on the windows, or using your keyboard to see the outputs.

#screenshots

##GNOME screenshot

Ubuntu 12.04 default on `PrtSc` key.

Change directory where images are saved:

    gsettings set "org.gnome.gnome-screenshot" "auto-save-directory" "file:///home/$USER/screenshot"

Default shortcuts on Ubuntu 12.04:

- `PrtSc`: take screenshot of entire screen
- `Alt` + `PrtSc`: take screenshot of current window, the menu including bar. `gnome-screenshot -w`.
- `Shirt` + `PrtSc`: start a crosshair cursor and take screenshot of a given selection. `gnome-screenshot -a`.

Useful options:

- remove menu bar: `wB`

##xwd

Take screenshots.

Mnemonic: X11 Write Dump.

Take screenshot of all desktop:

	xwd -root -out a.xwd

Wait for mouse click and take screenshot of clicked window only:

	xwd -out a.xwd

Make a `png` screenshot:

	xwd | xwdtopnm | pnmtopng > Screenshot.png

##recordeMyDesktop

Makes videos out of your desktop.

Capable of generating only `ogv` container, not `mkv`.

Comes in both command line, and GUI versions. The GUI does not add much, so stick to the CLI.

Most useful command:

    alias rmd='sleep2 && paplay ~/share/sounds/alert.ogg && recordmydesktop --stop-shortcut Control+Mod1+z'

- start recording in 2 seconds
- play a sound before it starts
- stop on `Ctrl + C` on terminal or `Control + Alt + Z` from any window. Rationale: easy to press with a single hand.
- save output to `out.ogv`, `out-1.ogv`, ...

Use if from a drop-down terminal like Guake so in the 2 seconds you can make it disappear.

#Desktop environment

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

##GNOME

GNOME 3 is the default DE for Fedora.

The GNOME project maintains GTK and many desktop software components.

Default window manager: `mutter`

Default session manager: `gnome-session`

Integrated control panel frontend: `gnome-control-center`.

Acts as a large frontend for several things such as printers, screen, etc., much like Window > Start > System.

Good way to manage GTK themes and other GNOME things: `gnome-tweak-tool`.

##Unity

Default DE for Ubuntu 12.04+.

###Unity window manager

Default window manager: Ubuntu 13.04 ships with 2 Compiz *and* Metacity, the choice depends on your hardware support: <http://askubuntu.com/questions/24977/why-does-ubuntu-use-two-window-managers-compiz-and-metacity>

Most modern laptops have enough hardware for Compiz.

You can decide which one is use via:

    ps -A | grep -e compiz -e metacity

###Unity panel

Named: unity-panel-service.

An important part of Unity (basically the only distinctive feature of most DEs)

###Unity utility

Restart the unity shell only, less effective and drastic than restarting LightDM:

    unity --restart

###Applets

####Alarm clock applet

Notifies you with sounds when a certain time passed.

####weather indicator

##KDE

Default DE for the KDE distro.

Uses Qt toolkit instead of GTK.

GNOME and KDE rivalry started when KDE chose to use QT in 1998 which was not GPL source for non-X11 platforms.

As of Qt 4, LGPL versions of Qt exist on all platforms, but the damage has been done: the open source community is divided and maintain duplicate versions for many desktop software, thus using up resources.

###applications

KDE offers both basic building blocks, and full applications.

The software offered is called the [KDE Software Compilation](http://www.kde.org/community/whatiskde/softwarecompilation.php).

KDESC applications release at the same time as new KDE versions. For example, Okular ships a specific release with every new KDE base version, and its git tags are exactly KDE versions.

There are also projects which use KDE, but which are not part of the KDESC.

###libs

A typical KDE application relies on the following shared libraries:

    libkparts.so.4
    libkio.so.5
    libkdeui.so.5
    libQtGui.so.4
    libkdecore.so.5
    libQtCore.so.4
    libQtDBus.so.4

###kde4-config

Get information on KDE configuration on current system.

Installation prefix:

    kde4-config --prefix

The value is usually `/usr`

This means for example that there will be many shared object files under `/usr/lib/kde4/`, and that the installed executables will go under `/usr/bin`.

##LXDE

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

###keyboard layout

<http://www.pclinuxos.com/forum/index.php?topic=87702.0>

Right click on panel and add the Keyboard Layout Handler to the panel.

Right click on the Keyboard layout manager and choose your settings.

TODO what are the available layouts? What are the config files?

#display manager

Shows the initial login screen where you can:

- enter your username and password
- shutdown the computer
- select which desktop environment to run (GNOME, Unity, KDE Plasma, etc.)

Some implementations:

- LightDM (lightweight), Ubuntu
- KDM, KDE
- GDM (gnome) fedora

Find your default X display manager:

    cat /etc/X11/default-display-manager

Log out from the graphical TTY and go back to the display manger login screen <http://askubuntu.com/questions/180628/how-can-i-logout-from-the-gui-using-cli>:

    kill -9 -1

`man kill` tells us that here:

- `-9` is for signal number 9, `SIGKILL`
- `-1` is a special number, which means all PIDs except for init and the kill process itself.

##lightdm

Default display manager for Ubuntu.

Sources

-   <https://wiki.ubuntu.com/LightDM>

    Ubuntu docs

Desktop chosen on last login:

    echo $GDMSESSION

Configuration file:

    less /etc/lightdm/lightdm.conf

Don't edit the configuration file directly, use this instead:

    sudo /usr/lib/lightdm/lightdm-set-defaults --hide-users true

Options:

-   allow-guest

-   `--autologin-user <username>`: auto-login the given user at startup without asking for password.

        sudo /usr/lib/lightdm/lightdm-set-defaults --autologin "$USER"

-   `--session <session>`: which session to log into. Examples: Ubuntu, LXDE, etc.

    The possibilities can be found at:

        ls /usr/share/xsessions

-   `display-setup-script=[script|command]`

-   `--hide-users <true-false>`: if false, don't show user list to select from.

    This prevent users from discovering the names of all users on the system.

Restart LightDM:

    sudo restart lightdm

Also restarts X. Closes all your programs that have windows.

Only do this on a tty, not on an xterminal probably because your terminal is going to die in the middle of the operation

#Window manager

An X window manager interacts with X to do things like:

- window switching (alt tab / visible list of open windows)

- maximize, minimize, full screen

- multiple desktops functionality

- the title bar, including the application's icon, the buttons to minimize, maximize, close, and what happens on drag (move window) or right click (show window options).

Window managers are X Clients.

It does not take care of:

- panel
- desktop
- what happens inside windows (this is usually managed with a toolkit like gtk or qt)

Implementations:

- Metacity
- Compiz

Get currently used window manager info:

    wmctrl -m

##Openbox

Default for LXDE.

Minimalistic.

Very fast.

Graphical configuration tool.

    obconf

You can change themes there, but not all config options are modifiable from there.

Configuration file:

    vim ~/.config/openbox/lxde-rc.xml

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

For the right, the minus sight `-` indicates that the distance is between the right edge of the window and the right screen edge.

It is possible to bind keys to shell commands as follows:

    <keybind key="W-F">
        <action name="Execute">
            <command>wmctrl -a '- mozilla firefox'</command>
        </action>
    </keybind>

Restart after changing config file to apply the changes:

    openbox --restart

Does not close applications.

##mutter

##Compiz

Passes window decoration to a Compiz window decorator.

Some Compiz window decorators:

- `gtk-window-decorator`: uses GTK for window decoration
- emerald:

Configurations: `gconf-editor` under `apps.compiz-1`.

Restart Compiz after modifying configurations to load them:

    compiz --replace

You should do this from a tty other than `tty7`.

#session manager

TODO

#startup programs

User space startup programs can only start after the display manager has logged the use in.

Therefore, they must either be launched by the DM at the end of its operation, or by something spawned by it.

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

TODO who executable implements it? Which DEs adopt it?

#toolkits

Although there is a X11 C interface, consider using higher level, more portable and more convenient interfaces such as:

##Qt

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

##GTK

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

##TODO how to find if an application uses GTK and which version

It is not generally possible to do so.

If the program uses GTK as a dynamic library, you can try:

    ldd /bin/ls

However some programs seem to use GTK as a static library.

Sometimes, programs also give GTK specific options from the command line.

---

TODO where is GTK configuration stored?

You can install new GTK themes by placing their files under TODO.

Note however that it is more recommended that you get themes from packages, so that those can get automatically updated.

#Themes

Control how the system looks.

Theme folders:

- `/usr/share/themes/`
- `~/.themes/`

Those folders contain themes for GTK and window managers.

Each directory structure is like:

- `/usr/share/themes/theme-name/gtk-2.0`
- `/usr/share/themes/theme-name/openbox-3.0`

TODO where are Qt themes stored?

#Panels

Like windows GUI item that contains the start menu.

Typically offer:

- a way to launch programs so that users can: type any part in the middle and click on the auto completed desired match
- contain a list of all windows so that users can point click to open a window
- contain a list of programs so that users can click to open the programs
- holds applets: small icons that offer interface for processes which users don't want to have a window, such as clock, logout/shutdown GUI, Internet connection.

Panels are X clients.

##LXPanel

LXDE default.

Configuration files: `.config/lxpanel/LXDE/`

##dconf vs gconf vs gsettings

Applications can them to manage user preferences. in key/value manner, where keys are put in a `/` separated tree.

Created by the gnome project.

Sources:

- <http://askubuntu.com/questions/22313/what-is-dconf-what-is-its-function-and-how-do-i-use-it>
- <http://askubuntu.com/questions/249887/gconf-dconf-gsettings-and-the-relationship-between-them>
- gconf vs dconf: <http://askubuntu.com/questions/34490/what-are-the-differences-between-gconf-and-dconf>

###dconf

DConf is the new backend for gsettings.

It is also the name of a CLI utility used to view and edit dconf settings.

Completely separate schema to gconf.

It should be used on new apps instead of gconf.

Uses a binary data format instead of XML, which implies that:

- fast to parse. Specially important as startup.
- not human readable.
- corruption of part of it can kill all the data in one go.
- binary config file located at: `~/.config/dconf/user`

View all dconf configs at once:

    dconf dump / | less

Here you see a reverse URL dot notation:

    org.gnome.metacity

GUI editor: `dconf-editor`.

    dconf write org/gnome/gnome-screenshot/auto-save-directory "/home/ciro"

###gconf

XML based.

Older than dconf.

Each config tree is implemented as actual directories with files at the nodes.

Config files: `~/.gconf/`

CLI view / edit tool: `gconftool-2`

Get all the XML confs:

    gconftool --dump / | less

GUI editor: `gconf-editor`

##gsettings

gsettings is a frontend for both dconf on Linux, and possibly other backends on other systems such as the Windows registry (binary).

Therefore, applications should only use it directly, and not dconf, to achieve greater portability.

On current GNOME based desktops, it does not support GConf.

Set the value of a key:

    gsettings set "org.gnome.gnome-screenshot" "auto-save-directory" "file:///home/$USER/screenshot"

Normal not hidden scroll bars:

    gsettings set com.canonical.desktop.interface scrollbar-mode normal

Show username on panel:

    gsettings set com.canonical.indicator.session show-real-name-on-panel true

Return key to its default value:

    gsettings reset com.canonical.desktop.interface scrollbar-mode

#power

##shutdown

Sends TODO signal to running processes and waits for them to terminate nicely:

    sudo shutdown -P now

##reboot

    sudo reboot

##suspend and hibernate

Sources:

- <https://help.ubuntu.com/community/PowerManagement/Overview>
- <http://askubuntu.com/questions/1792/how-can-i-suspend-hibernate-from-command-line>

Both can be done with `pmi`, `pm-utils` or `dbus-send`

###suspend

Keeps things on RAM, but pauses all processes that can be paused, and turns off screen.

You need to use a bit of power to keep it suspended.

###hibernate

Save RAM to disk, shuts down almost everything.

Uses very little to no power.

TODO pmi vs pm-utils?

##ACPI

TODO

##pm-utils package

Maintained by freedesktop.org: <http://pm-utils.freedesktop.org/wiki/>

Mnemonic: Power Management.

    pm-suspend
    pm-hibernate

##pmi

    pmi action suspend
    pmi action hibernate

#Lock screen

State in which user must enter a password to be able to do or see anything.

Does not necessarily suspend computer for power saving.

Usually fires up the screensaver.

#Screensaver

Available screensavers at `$XDG_CONFIG_DIRS/screensaver` as desktop files.

You can execute screensavers under `TryExec` of the desktop entries to see how they look like.

##xdg-screensaver

XDG utils package

Lock screen and activate screensaver:

    xdg-screesaver activate

Seems to reset to the current desktop's default if any is recognized such as gnome-screensaver.

##xscreensaver

Seems to fail is another screensaver such as gnome-screensaver can run.

##gnome-screensaver

Seems that it was rewritten and screensaver change is not implemented as of 07/2013: <http://askubuntu.com/questions/64086/how-can-i-change-or-install-screensavers>

#D-Bus

IPC library and daemon.

Specified by freedesktop.org: <http://www.freedesktop.org/wiki/Software/dbus/>

Main method used for IPC in KDE 4 and GNOME.

##dbus-monitor

View D-Bus messages as they are sent.

##dbus-send

Suspend computer:

    dbus-send --system --print-reply \
        --dest="org.freedesktop.UPower" \
        /org/freedesktop/UPower \
        org.freedesktop.UPower.Suspend

##libdbus

Library that allows application to communicate with D-Bus.

#Desktop file format

Files with extension `.desktop`.

Data format used on many different XDG specs.

The fields it can contain are left for each spec: this only specifies syntax. Analogy: this is `xml`, not `html`.

Specs: <http://standards.freedesktop.org/desktop-entry-spec/latest/>

#Applications desktop files

This discusses the desktop files under `$XDG_DATA_DIRS/applications` such as `$XDG_DATA_DIRS/applications/firefox.desktop`.

Sources:

-   <https://developer.gnome.org/integration-guide/stable/desktop-files.html.en>

    GNOME tutorial. Claims to follow freedesktop.org specs: <http://standards.freedesktop.org/menu-spec/latest/index.html>

Those files contain metadata about programs, which can be used by the DE to improve user experience.

The commonly understood difference between the terms application and program is exactly that: applications is mostly a program with DE metadata, while program is mostly the executable.

Sample file (abridged):

    [Desktop Entry]
    Name=Firefox Web Browser
    Name[es]=Navegador web Firefox
    Comment=Browse the World Wide Web
    Comment[es]=Navegue por la web
    GenericName=Web Browser
    GenericName[es]=Navegador web
    Keywords=Internet;WWW;Browser;Web;Explorer
    Keywords[es]=Explorador;Internet;WWW
    Exec=firefox %u
    Terminal=false
    X-MultipleArgs=false
    Type=Application
    Icon=firefox
    Categories=GNOME;GTK;Network;WebBrowser;
    MimeType=text/html;text/xml [actually much longer than this!]
    StartupNotify=true
    Actions=NewWindow;NewPrivateWindow;

    [Desktop Action NewWindow]
    Name=Open a New Window
    Exec=firefox -new-window
    OnlyShowIn=Unity;

    [Desktop Action NewPrivateWindow]
    Name=Open a New Private Window
    Exec=firefox -private-window
    OnlyShowIn=Unity;

How this file could be used by the DE:

-   when users want to search for an application, and they don't know the exact name for the application, they can query for metadata.

    For example on Ubuntu Panel, if you type `WWW`, Firefox will be suggested, because `WWW` is in its keywords metadata.

-   when a file with unknown type is going to be opened, if there are no associations to it, the DE could use the `MimeType` field to make suggestions, of possible suitable alternatives.

##Icon

Icons are needed at several places to help identify the application:

- when showing a program suggestion list
- when switching windows

The icon is identified by the `Icon` field, which corresponds to a file under `XDG_DATA_DIRS/icons`.

That directory may contain multiple versions of each icon, at various resolutions, color depths and styles, since icon themes can also change with DE settings. `hicolor/48x48` should contains lots of standard icons.

#Default applications

This talks about how to allow users to choose their default application when opening certain types of file.

There are many systems, and they have some degree of compatibility.

##xdg-open

XDG utils package, part of the LSB.

Can open both Internet URLs and local files:

    echo a > a.html
    xdg-open a.html

    xgd-open http://google.com

Sources:

- <https://wiki.archlinux.org/index.php/Default_Applications>

Preferred choice for default program opening command since it is desktop/window manager agnostic.

See this: <https://wiki.archlinux.org/index.php/Xdg-open>

It seems that if a desktop is detected such as GNOME, options for that desktop override this options, so for example under GNOME, this just passes control to `gnome-open`.

Based on MIME type of file to open, not extension.

Configuration files:

- MIME -> program mapping under `$XDG_DATA_DIRS/applications`, either `defaults.list` (old) or `mimeapps.list` (new).

###update-mime-database

shared-mime-info package.

##gnome-open

Gnome specific. Use `xdg-open` instead..

##kde-open

KDE specific. Use `xdg-open` instead..

##alternatives system

One configuration method is to make symbolic links such as `/usr/bin/editor` to either `vi` or `ed` for example.

The standard way is to first link `/usr/bin/editor` to `/etc/alternatives/editor`, and then `/etc/alternatives/editor` to the desired executable (say `/usr/bin/vi`).

In this way, all preferences are stored under `etc` as specified by the LSB.

##update-alternatives

The `update-alternatives` utility can be used to manage that system.

For example, to configure the default browser use:

    sudo update-alternatives --config x-www-browser

This will show the possibilities (TODO how does he know?) for you to choose from them.

The most important alternatives include:

- `editor`: text editor
- `x-www-browser`: web browser

TODO: understand the following command:

    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50

- `50`: priority of the alternative. Metadata associated by `update-alternatives`. Alternative with greatest priority wins.

I used this to link `gcc` to `gcc-4.8` instead of `4.6`.

#logkeys

Writes all key presses to a file.

Great way to steal people's passwords if they use your computer.

Start logging:

    sudo logkeys -s

End logging:

    sudo logkeys -k

#IBus input methods

Daemon for Chinese, Japanese, etc. input.

On Ubuntu, you must install the Qt version separately for it to work on Qt apps via:

    sudo aptitude install -y ibus-qt4

#Solaar

Monitor status and configure Logitech wireless devices.

List devices:

    solaar-cli show

List configuration of device:

    solaar-cli config 1

TODO how to change the Fn swap (in some keyboards, if you press F1 it does the Fn version istead). The following fails:

    sudo solaar-cli config 1 fn-swap false

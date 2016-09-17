# Window manager

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

## Openbox

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

## mutter

## Compiz

Passes window decoration to a Compiz window decorator.

Some Compiz window decorators:

- `gtk-window-decorator`: uses GTK for window decoration
- emerald:

Configurations: `gconf-editor` under `apps.compiz-1`.

Restart Compiz after modifying configurations to load them:

    compiz --replace

You should do this from a tty other than `tty7`.

## Matchbox

Minimalistic, one window at a time only. Embedded focus. Buildroot 2016-05 has a package for it.

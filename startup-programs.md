# Startup programs

User space startup programs can only start after the display manager has logged the use in.

Therefore, they must either be launched by the DM at the end of its operation, or by something spawned by it.

Used by Ubuntu, LXDE, KDE, GNOME

Specification by freedesktop.org: <http://standards.freedesktop.org/autostart-spec/autostart-spec-latest.html>

Configuration files under:

- `/etc/xdg/autostart`
- `~/.config/autostart/`

Each file gets sourced.

Example, in a file called `firefox`, put:

    [Desktop Entry]
        Type=Application
        Exec=firefox

TODO who executable implements it? Which DEs adopt it?

Ubuntu 15.10 has `gnome-session-properties` from package `gnome-session-bins` is a GUI editor for those file.

## X-GNOME-Autostart-enabled

Enable or disable one of the startup files:

    X-GNOME-Autostart-enabled=false
    X-GNOME-Autostart-enabled=true

You could of course remove it, but this is better as it keeps the rest of the data.

Renaming the file to something like `file.desktop.off` is another option.

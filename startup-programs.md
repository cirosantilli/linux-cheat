# Startup programs

User space startup programs can only start after the display manager has logged the use in.

Therefore, they must either be launched by the DM at the end of its operation, or by something spawned by it.

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

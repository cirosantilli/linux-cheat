# Desktop files

Spec:

- <http://standards.freedesktop.org/menu-spec/latest/index.html>
- <https://specifications.freedesktop.org/desktop-entry-spec/latest/index.html>

Arch Linux wiki tutorial: <https://wiki.archlinux.org/index.php/Desktop_entries>

Major places where `.desktop` files are used are:

- `$XDG_DATA_DIRS/applications` for default application associations such as `.local/share/applications/firefox.desktop`.
- `.config/autostart` for startup applications

Those files exist to add extra GUI information to executables or scripts, e.g.:

- name and icon to show on GUI launchers
- extra keywords and categories to help users find the program
- Xorg properties of created windows, e.g. class

Good source: GNOME tutorial: <https://developer.gnome.org/integration-guide/stable/desktop-files.html.en>

Those files contain metadata about programs, which can be used by the DE to improve user experience.

The commonly understood difference between the terms application and program is exactly that: applications is mostly a program with DE metadata, while program is mostly the executable.

## Desktop file format

Files with extension `.desktop`.

Data format used on many different XDG specs.

The fields it can contain are left for each spec: this only specifies syntax. Analogy: this is `xml`, not `html`.

Specs: <http://standards.freedesktop.org/desktop-entry-spec/latest/>

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

## Terminal

Opens a terminal window, run the commands there, and close the terminal window as soon as it exits. Try with this:

    Exec=sh -c "echo a; date >/tmp/test.desktop; sleep 10;"

<http://askubuntu.com/questions/436891/create-a-desktop-file-that-opens-and-execute-a-command-in-a-terminal>

## Exec

What to execute.

<https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html>

Multiple commands:

    Exec=sh -c "cmd1 && cmd2"

Arguments:

    Exec=sh -c "cmd1 %F && cmd2"

`%f` provides the full path to the file.

`"`, `\\` and `\`` need to be extra escaped in exec sometimes. TODO why?

## Icon

Icons are needed at several places to help identify the application:

- when showing a program suggestion list
- when switching windows

The icon is identified by the `Icon` field, which corresponds to a file under `$XDG_DATA_DIRS/icons`.

That directory may contain multiple versions of each icon, at various resolutions, color depths and styles, since icon themes can also change with DE settings. `hicolor/48x48` should contains lots of standard icons.

## NoDisplay

Don't show in menus.

Typical use case: associate mime type to open on a new tab of a running program.

## desktop-file-validate

## desktop-file-edit

## desktop-file-install

Installs to the system shared directory, requires sudo.

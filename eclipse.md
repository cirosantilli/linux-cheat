# Eclipse

Programming IDE.

## Vs Vim

Advantages over Vim:

- everything coded in Java
- huge Java integration

Downside:

- whatever you want to do you must click 50 menu items and there is no way to automate it
- many windows are not buffers. In Vim, everything is a buffer, e.g., a file browser, so you can reuse all file editing shortcuts.
- obtrusive interface: not possible to remove the bottom bar, huge warning on left

## Install Eclipse

Install Eclipse as a regular user, not as root or via package managers like `apt-get` because:

- you will get a much more updated version
- apt-get install crashes on Ubuntu 12.04!
- you need to open Eclipse with sudo to install packages. This causes other problems of its own.

## Preferences

Preferences, settings are under Window > Preferences

Make package manager follow current editor file:
<http://stackoverflow.com/questions/6334241/how-do-i-show-an-open-file-in-eclipse-package-explorer>

It is not possible to customize tab labels as with Vim's `guitablabel`:
<http://stackoverflow.com/questions/3450648/smarter-editor-tab-labels-in-eclipse>

### Spell checking

To add a word to the dictionary, you must first create the user dictionary. To get started, touch a `dict` file on your workspace, the search for spelling under preferences, and point to it.

To add words to the dictionary, hit F2, then click on add word to dictionary.

### Line wrapping

<http://stackoverflow.com/questions/2846002/does-eclipse-have-line-wrap>

Hard is possible, soft is notoriously not.

### Project preferences

On the package explorer, click on the project and hit `Alt + Enter` or go File > Properties.

From there you can do things like:

- set how the project is run (`F12`), e.g. passing command line arguments to the program or to the VM.

## Keyboard shortcuts

General > Keys

Navigate in editor and its tabs:

-   `F3`: open definition in a new tab

-   `Alt left`: go to the last location. May jump between lines and change tabs.

-   `Ctrl + Shift + T`: find class definition (Type). Does a sort of Fuzzy search for capital letters.

-   `Ctrl + Shift + R`: find files.

-   `Ctrl + O`: dropdown filter jump to method definition in current file

    Search entire

-   `Ctrl + H`: search for Java things. Allows you to select classes, methods, fields, etc.

-   `Alt + Shift + Q + XXX`: focus on many different things depending on `XXX`

    - `P`: Package Explorer

-   `Alt + Shift + X + XXX`: run things

    - `J`: Java. Runs the `main` of the file
    - `T`: JUnit test.

-   `Ctrl + T`: show a popup with type hierarchy of current class file. You can then click on the classes to jump to them.

-   `Ctrl + Shift + Down/Up`: move to the next / previous class member

-   `Ctrl + E`: show a filter dropdown with the tabs

-   `F4`: show hierarchy of class under cursor

-   `Ctrl + Alt + H`: show call graph of method under cursor.

    Looks something like:

    - `callsMethod1`
    - `callsMethod2`

    Then, as you click on each method of the tree, you open up it's own call graph:

    -   `callsMethod1`
        - `callsMethod_callsMethod1_1`
        - `callsMethod_callsMethod1_2`
    - `callsMethod2`

    and so on. This allows you to see exactly what changes to a method will impact.

Navigate across editor and other widgets:

-   `Ctrl + M`: Toggle maximize current window.

-   `F12`: focus editor

Edit:

-   `Ctrl + /`: toggle single line comment

-   `Ctrl + Alt + J`: toggle single line comment

-   `Ctrl + .` and `Ctrl + ,`: next and previous error or warning. <http://stackoverflow.com/questions/1832183/eclipse-how-to-go-to-a-error-using-only-the-keyboard-keyboard-shortcut>

-   `Ctrl + Shift + F`: auto format code using the current formatter.

Misc:

-   `F12`: run program. How it gets run is defined under the project properties.

## Non-keyboard stuff

-   Jump to overridden method: a little triangle appears to the left of the method.

    <http://stackoverflow.com/questions/3771934/eclipse-navigate-to-inheritor-base-declaration>

## Plugins

### Install

Install and search plugins through the Eclipse Marketplace.

From the IDE: Help > Eclipse Marketplace ... note the very intuitive placement under Help.

The website: <http://marketplace.eclipse.org/>

### Good plugins

Add Vim like editing to eclipse: <http://vrapper.sourceforge.net/update-site/stable>.

C and C++: <http://download.eclipse.org/tools/cdt/releases/indigo/>

Python: <http://pydev.org/updates>

HTML, JavaScript, PHP: <http://download.eclipse.org/webtools/repository/indigo/>

#### LaTeX

<http://texlipse.sourceforge.net>

Forward search to Okular:

Inverse search from Okular: Settings > Configure Okular > Editor

    Editor: custom text editor,
    Command: gvim --remote +%l %f

#### EGit

Configure: Preferences > Team

Parses git configure files as key value pairs and shows them on Eclipse. Doesn't even suggest possible key values.

#### Vrapper

<http://vrapper.sourceforge.net/home>

Some shortcuts that already exist in Eclipse were kept and the Vim version is not implemented. E.g. `Ctrl + R` is not implemented, so you have to use `Ctrl + Shift + Z` instead.

Block visual is `Ctrl + Shift + V` instead of `Ctrl + V` as in Vim to avoid conflict with paste. Eclipse also has a built-in block visual mode: <http://stackoverflow.com/questions/1053725/how-do-i-enable-the-column-selection-mode-in-eclipse>

### StartExplorer

<https://github.com/basti1302/startexplorer>

Open file explorer or shell on given folder from Package Explorer.

Custom commands: go to Preferences > StartExplorer > Custom Commands.

You can use variables as described at: <http://basti1302.github.io/startexplorer/help/05_custom_commands.html>

E.g., start Guake here:

    guake -n "${resource_loc}"

No bindings for custom commands yet: <https://github.com/basti1302/startexplorer/issues/5>

### MoreUnit

Jump between a class and it's test file:
<http://stackoverflow.com/questions/1399491/eclipse-function-plugin-that-finds-corresponding-junit-class>

TODO how to use this? Clicking `Ctrl + J` tries to create a new test class instead of jumping to the existing one!

### JaCoCo

Test coverage viewer plugin.

### Color themes

#### Editor color theme

Best place to find color themes: <http://eclipse-color-theme.github.com/update>. It already comes with many color themes.

The best way is to install the Eclipse Color Theme plug-in and install new plugins with General > Appearance > Color Theme

Otherwise to install `.epf` themes: File > Import > Preferences > Select *.epf

Vibrant Ink is a good choice as usual.

#### GUI color theme

For the rest of the GUI besides the editor, see Preferences > Appearance. `Dark` is the only one my eyes will accept, but id does break some functionality.

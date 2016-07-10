# KDevelop

Tested on 4.7.3.

Very good first impression for C++ CMake. Worked really fast, easy to find how to do the basic things that I need.

C / C++ focused, but other languages also supported: <http://developer.kde.org/~larrosa/visualtutorial/chapter02.html>

## Settings

- Vi input mode: Settings > Editing > Vi input mode > Use

## Navigate source

- Import existing source: File > Import > CMake. Done. Just works!
- Jump to definition: Ctrl + click.
- View class hierarchy and method layout: Right click on class name > Find in class browser
- Jump to previous location: Meta + Left (oh now, meta usage inside non window manager program...)
- Find uses: Right click > Find uses. Shows either calls, definitions or declarations.
- Next / previous tab keyboard shortcut: http://stackoverflow.com/questions/37050415/how-to-move-to-the-next-previous-right-left-file-tab-on-kdevelop-with-a-ke
- Ctrl + Alt + B: toggle breakpoint on current line
- Ctrl + Alt + O, type filename / symbol name: autocomplete jump to file that matches file / symbol

## TODO

- find uses of macro
- send stdin to running executable from console

## Build and run

- F8: compile
- Shift + F9: run

## Debug

First you must compile with debug symbols.

With CMake: <http://stackoverflow.com/questions/24322956/kdevelop-steps-and-breakpoints-not-working>

CMake manage multiple build configurations: <http://stackoverflow.com/questions/15064715/kdevelop-with-cmake-project-how-to-manage-debug-and-release-builds>

- F9: run in debugger mode. TODO: hitting it multiple times just stops the previous one and starts a new one?
- F10: GDB next
- F11: GDB step
- F12: GDB finish
- Continue: no default keyboard shortcut! I set it to Shift + F10.

Watch variable: hover it, Watch this. Could not find on right click...

Find the actual derived type of a pointer to a base class: TODO. For GDB only: <http://stackoverflow.com/questions/8528979/how-to-determine-if-an-object-is-an-instance-of-certain-derived-c-class-from-a>

Current UI for the debug pane is bad:

- jump to line of breakpoint on editor: <https://forum.kde.org/viewtopic.php?f=218&t=125905#p338944> No mouse method or visible indication!
- cannot select multiple breakpoints at once to delete them

## Bibliography

Documentation: https://docs.kde.org/trunk5/en/extragear-kdevelop/kdevelop/index.html

### Reviews

Positive:

- <http://www.gnurou.org/code/kdevelop-kernel>

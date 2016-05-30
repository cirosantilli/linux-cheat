# Eclipse

Programming IDE.

## Vs Vim

Advantages over Vim:

-   coded in Java and plugins also coded

-   huge out-of-the-box Java development integration:

    - great debugging interface
    - code navigation: click to jump to interface or definition
    - parses stdout stack traces

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

## Configuration

Preferences, settings are under Window > Preferences

Make package explorer follow current editor file: <http://stackoverflow.com/questions/6334241/how-do-i-show-an-open-file-in-eclipse-package-explorer>

It is not possible to customize tab labels as with Vim's `guitablabel`: <http://stackoverflow.com/questions/3450648/smarter-editor-tab-labels-in-eclipse>

Show full path to files: <http://stackoverflow.com/questions/3170379/eclipseide-is-there-a-way-to-add-the-workspace-path-to-the-eclipse-ide-title-ba> Important if you are running multiple Eclipse instances at once.

### Configuration files

Eclipse generates the following configuration files on projects:

- `.project`
- `.classpath`
- `.settings/`

You will want to gitignore them.

It does not seem possible to ask Eclipse to prevent Eclipse from creating those files: <http://stackoverflow.com/questions/12563878/how-to-prevent-creation-of-project-files-in-eclipse-navigator>

#### Eclipse.ini

Global file on `$ECLIPSE_HOME` or in the eclipse installation folder by default.

You should add more memory to the JVM that runs Eclipse for larger projects to load: <http://stackoverflow.com/questions/9565125/whats-the-recommended-eclipse-cdt-configuration-for-big-c-project-indexer-ta>

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

-   `Ctrl + Shift + G`: find where the id (class, method, etc.) under the cursor is used.

-   `Ctrl + O`: dropdown filter jump to method definition in current file

    Search entire

    `Ctrl + O Ctrl + O`: also view the methods of base classes.

-   `Ctrl + H`: search for Java things. Allows you to select classes, methods, fields, etc.

-   `Alt + Shift + Q + XXX`: focus on many different things depending on `XXX`

    - `P`: Package Explorer

-   `Alt + Shift + X + XXX`: run things

    - `J`: Java. Runs the `main` of the file
    - `T`: JUnit test.

-   `Ctrl + T`: show a popup with type hierarchy of current class file. You can then click on the classes to jump to them.

    If you are on top of a method, you will see a list of overriders / implementors.

    `Ctrl + T Ctrl + T`: toggle between quick type and supertype hierarchy.

-   `Ctrl + Shift + H`: open call hierarchy for method under cursor. Allows you to see who calls what.

    How to ignore tests: <http://stackoverflow.com/questions/9321408/hide-unit-tests-from-call-heirachy>

    How to ignore parent classes, e.g. `toString` on all Objects: <http://stackoverflow.com/questions/13792592/finding-references-of-myclass-tostring-in-eclipse>

-   `Ctrl + Shift + Down/Up`: move to the next / previous class member

-   `Ctrl + E`: show a filter dropdown with the tabs

-   `F4`: show hierarchy of class under cursor

-   `Ctrl + Hover` on abstract method: show implementations.

-   `Ctrl + Alt + H`: show call graph of method under cursor.

    Looks something like:

    - `callsMethod1`
    - `callsMethod2`

    Then, as you click on each method of the tree, you open up it's own call graph:

    -   `callsMethod1`

        - `callsMethod_callsMethod1_1`
        - `callsMethod_callsMethod1_2`

    -   `callsMethod2`

    and so on. This allows you to see exactly what changes to a method will impact.

-   `Ctrl + F8`, `Ctrl + Shift + F8`: open a popup and navigate perspectives forward and backwards.

    Because of the popup, this also allows you to determine your current perspective.

Navigate across editor and other widgets:

-   `Ctrl + M`: Toggle maximize current window.

-   `F12`: focus editor

Edit:

-   `Ctrl + /`: toggle single line comment

-   `Ctrl + Alt + J`: toggle single line comment

-   `Ctrl + .` and `Ctrl + ,`: next and previous error or warning. <http://stackoverflow.com/questions/1832183/eclipse-how-to-go-to-a-error-using-only-the-keyboard-keyboard-shortcut>

-   `Ctrl + Shift + F`: auto format code using the current formatter.

Misc:

-   Mouse select expression + `Ctrl + Shift + I`: view result of selected expression. Good way to analyse temporary return values.

-   `F12`: run program. How it gets run is defined under the project properties.

-   `Alt + Shift + S`: Source code dialog.

    Includes things like generation of annoying methods like `toString`, `equals` and `hashCode`.

    The generated `hashGode` appears to be good, a similar approach is used by the JCL: <http://stackoverflow.com/questions/11795104/is-the-hashcode-function-generated-by-eclipse-any-good>


-   `Alt + Shift + J`: generate Javadoc comments for method under cursor

## Debug

-   Double click on the gutter to add a breakpoint to a line.

### Types of breakpoints

-   Statements. The most common ones.

-   Classes.

-   Exception breakpoints can be created from the breakpoints view through the `J!` button.

    You them chose the class of the exception and run the debug mode.

    If a selected exception is thrown, the debug mode starts when that happens.

    So you can now view the state of all variables through the exception trace.

-   Filed access breakpoints. Active whenever a field changes value.

-   Methods. TODO vs regular line breakpoints? You can choose either entry or exit from the method.

Breakpoints can be conditional, and only turn on on certain conditions.

Breakpoints conditional on stack trace have been marked WONTFIX: <http://stackoverflow.com/questions/14381446/conditional-breakpoint-by-caller-in-java-eclipse> The workaround is to make them conditional on:

    StackTraceElement[] arr = Thread.currentThread().getStackTrace();
    boolean contains = false;
    for(StackTraceElement e : arr) {
        if (e.getClassName().contains("A")) {
            contains = true;
            break;
        }
    }

### Start debugging

-   `F11`: debug program. If on a test file, run it. Else, runs the same debug that was last launched with `Ctrl + Alt + D + t`.

-   `Alt + Shift + D T`: run current JUnit file in debug mode.

    Jumps to the first break-point. Then you can use:

    -   `F5` to go into method calls or move to the next statement.

        If you hold this, you will see every single thing that your program is does.

    -   `F6` to go to the next statement

    -   `F7` end current method

    -   `F8` to run until the next breakpoint or end of execution

    `Ctrl + Shift + B` toggles the breakpoint on the current line.

-   From the JUnit results window, right click on a test, and click debug. This will run only the given test method.

---

-   Select method and `Ctrl + F5`: step into selection.

    When there are many method calls on a single line, this jumps into the selected method.

-   When variables change value from the last step, they are highlighted on the variables view: <http://superuser.com/a/881424/128124>

-   By default, when you start debugging Eclipse automatically opens the debug perspective.

    When you finish debugging, there is currently no way of automatically going back to the main Java perspective:
    <http://stackoverflow.com/questions/521442/in-eclipse-how-do-i-change-perspectives-after-terminating-a-process>

-   `Ctrl + Shift + I`: view the result of the selected expression.

    This is useful to inspect the result of temporary variables which exist just for one line, e.g.:

        String s = new String(new String("a"));
                              ^^^^^^^^^^^^^^^

    if you want to get the value of `new String("a")`.

    Note that for an expression, you must select it from the beginning. E.g.:

        object.method()
               ^^^^^^^^

    will not work, you need instead:

        object.method()
        ^^^^^^^^^^^^^^^

### Variable inspection

The variables view shows the values of variables.

You can recursively expand object fields to inspect their entire state.

Bellow the field tree, the variable view shows the `toString` of the object, which you should always define.

Furthermore, for complex objects like Maps, you will want a special view that only shows the keys, and not the complex implementation details. You can achieve this through the "logical view" button. For each interface you can configure a different logical view under "Preferences > Java > Debug > Logical Structure".

It is also possible to edit the table tooltip for each field through the debug configuration "Add detail formatter" configuration: <http://stackoverflow.com/questions/7275520/eclipse-debugging-hashmap-logical-structure-using-key-and-values-tostring-me>

### Go back in time

### Find where a variable was last changed

Not possible in Eclipse.

This requires the so called *omniscient debuggers*, which keep a list of all changed variables. The problem is that those debuggers take up much more memory.

## Jump to implementation

<http://stackoverflow.com/questions/3255530/jump-into-interface-implementation-in-eclipse-ide>

The easiest built-in way seems to be to hit F4 and navigate the type hierarchy.

## Snippets

SnipMate-like snippets are called templates in Eclipse.

## Templates

Preferences > Editor > Templates.

Don't confuse with the "Code templates" under Java, which are templates that expand on file / class creation.

Ctrl + Space to complete them. They may conflict with types, in which case both appear in the same list. Templates seem to always appear first.

If you type an unique prefix of the name, it expands.

Most useful meta variables:

- `${any-unued-parameter}`: a placeholder. Hit enter to jump to the next one.
- `${cursor}`: position of the cursor when expansion ends.

## Non-keyboard stuff

-   Jump to overridden method: a little triangle appears to the left of the method.

    <http://stackoverflow.com/questions/3771934/eclipse-navigate-to-inheritor-base-declaration>

### Javadoc

You can see the Javadoc of a project by hovering the mouse over the ID.

Eclipse searches for Javadoc in several places:

-   open files

-   on `.jar`s that are placed at the same directory as the source of the class.

    Those `.jar` contain should contain either the Javadoc tree or the source code that corresponds to that of the project.

    Maven can be used to generate those files. The common naming convention is to distribute all of:

    - `artifact-version.jar`
    - `artifact-version-javadoc.jar`
    - `artifact-version-sources.jar`

    in a single directory.

## Plugins

### Install

Install and search plugins through the Eclipse Marketplace.

From the IDE: Help > Eclipse Marketplace ... note the very intuitive placement under Help.

The website: <http://marketplace.eclipse.org/>

### Good plugins

Add Vim like editing to eclipse: <http://vrapper.sourceforge.net/update-site/stable>.

Python: <http://pydev.org/updates>

HTML, JavaScript, PHP: <http://download.eclipse.org/webtools/repository/indigo/>

#### CDT

#### C++

Hard to get working...

C and C++: <http://download.eclipse.org/tools/cdt/releases/indigo/>

For large projects, make sure that you add more memory to the VM at `Eclipse.ini` or the indexing hangs: <http://stackoverflow.com/questions/9565125/whats-the-recommended-eclipse-cdt-configuration-for-big-c-project-indexer-ta>

Change file extension for C++:

- <http://stackoverflow.com/questions/4728531/how-to-change-the-default-c-class-suffix-in-eclipse-cdt>
- <http://stackoverflow.com/questions/226402/make-eclipse-treat-h-file-as-c>

Useful to develop GCC, which uses `.c` and `.h` as C++...

#### LaTeX

<http://texlipse.sourceforge.net>

Forward search to Okular:

Inverse search from Okular: Settings > Configure Okular > Editor

    Editor: custom text editor,
    Command: gvim --remote +%l %f

#### EGit

Configure: Preferences > Team

Parses git configure files as key value pairs and shows them on Eclipse. Doesn't even suggest possible key values.

Don't forget to turn-off the auto-modification of `.gitignore` which comes on by default. I hate it when Eclipse touches my source `:@`! <http://stackoverflow.com/questions/17748223/egit-and-eclipse-modifies-gitignore-file-but-it-should-not>:

    Preferences > Team > Git > Projects and deselect "Automatically ignore derived resources by adding them to .gitignore".

Features:

-    `Ctrl + Shift + Q`: quick diff: shows on a small column to the left changed, inserted and deleted lines between the editor state and `HEAD~`, each with a different color. Deleted lines are marked between existing lines where they where.

-   `Right click on sidebar > Show annotations`: author / change date color blame side by side with the editor. Hides the quick diff.

    `Right click on sidebar > Revisions > Hide revision information`: undo the above. Highly unintuitive, since it is a toggle option, but you have to go to a different path to turn it off!

    On hover, the commit information is shows.

    `Right click on sidebar > Revisions > Show Author / Id`: show the Author / 7 character SHA of each blame commit.

#### Vrapper

<http://vrapper.sourceforge.net/home>

Some shortcuts that already exist in Eclipse were kept and the Vim version is not implemented. E.g. `Ctrl + R` is not implemented, so you have to use `Ctrl + Shift + Z` instead.

Block visual is `Ctrl + Shift + V` instead of `Ctrl + V` as in Vim to avoid conflict with paste. Eclipse also has a built-in block visual mode: <http://stackoverflow.com/questions/1053725/how-do-i-enable-the-column-selection-mode-in-eclipse>

### StartExplorer

<https://github.com/basti1302/startexplorer>

Open file explorer or shell on given folder from Package Explorer.

Custom commands: go to `Preferences > StartExplorer > Custom Commands`.

You can use variables as described at: <http://basti1302.github.io/startexplorer/help/05_custom_commands.html>

E.g., start Guake here:

    guake -n "${resource_loc}"

No bindings for custom commands yet: <https://github.com/basti1302/startexplorer/issues/5>

### MoreUnit

Jump between a class and it's test file:
<http://stackoverflow.com/questions/1399491/eclipse-function-plugin-that-finds-corresponding-junit-class>

TODO how to use this? Clicking `Ctrl + J` tries to create a new test class instead of jumping to the existing one!

### JaCoCo

### EclEmma

Test coverage viewer plugin.

`JaCoCo` is the backend.

Go to a JUnit test, then `Alt + Shift + E T`. This runs the test, and colors places the code that were covered or not.

To remove the highlight, click on the `X` of the Coverage window. You can also assign a keyboard shortcut to it. And if you change a file, the coverage highlight disappears.

`Ctrl + Alt + Q O` opens the coverage window.

For each branch, it puts a diamond on the left gutter that says how many of the branches (true / false) were covered at least once: red for 0, yellow for 1 and green for both.

On the test itself, the highlight indicates which zones have been run or not.

### Built-in terminals

<http://stackoverflow.com/questions/1562600/is-there-an-eclipse-plugin-to-run-system-shell-in-the-console>

#### TCF Terminals

Works, but useless since no auto `cd`. Maybe in version 3?

Launch with `Ctrl + Alt + T`, which conflicts with Ubuntu's bad terminal launch shortcut, which should include the Super key as any decent global shortcut.

### Color themes

#### Editor color theme

Best place to find color themes: <http://eclipse-color-theme.github.com/update>. It already comes with many color themes.

The best way is to install the Eclipse Color Theme plug-in and install new plugins with General > Appearance > Color Theme

Otherwise to install `.epf` themes: File > Import > Preferences > Select *.epf

Vibrant Ink is a good choice as usual.

#### GUI color theme

For the rest of the GUI besides the editor, see Preferences > Appearance. `Dark` is the only one my eyes will accept, but id does break some functionality.

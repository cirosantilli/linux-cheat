# Terminal

Cheat on terminal emulators.

Terminal emulators are called *emulators*, because they *emulate* machines of the past called terminals which allowed to interface with computers.

Those machines are now extinct, but their human machine interface legacy lives on through the software incarnations of those machines which we call terminal emulators.

The exact operation of terminal emulators is not standardized by POSIX (TODO check) but rather a de facto standard inherited from an influential terminal (a machine) that was very popular in the past called the VT100. We shall therefore describe here VT100 like terminal emulators.

## Control characters

When most key presses are entered on the terminal, they simply get printed to the screen, for example `a`, `?` etc.

Furthermore, those key presses only take effect after the <enter> key is pressed.

However, some input bytes lead the terminal immediate effect on a terminal, even before `<enter>` is pressed to send characters.

For many of those bytes, the terminal to send certain signals to applications. Signals are a well defined ANSI C and POSIX concept, and part of what follows will be clearer if you know about them. Signals shall not be discussed here in detail.

To test the process control jobs, use the helper script:

    alias seqs='for i in 1 2 3 4 5; do echo $i; sleep 1; done'

which prints one integer per second.

### c-c

Send a `SIGTERM` signal to the foreground process.

Run:

    sleep 5

and then do `<C-C>` while it runs.

This kills sleep, since it is not programmed to handle `SIGTERM`.

This is very useful when you want the current application to stop running, because it is taking too long and you don't care about losing its data.

Note however that applications can handle `SIGTERM`, and some pesky applications won't terminated on `<C-C>` (some may at least ask you if you want to terminate, or tell you how to do so).

### c-\

Send a `SIGQUIT` to foreground process.

### c-z

Send a `SIGSTOP` to foreground process, and put it on background.

As one may expect, `SIGSTOP` has the effect of stopping the process.

Run:

    seqs 5

And then do <C-Z> while it runs.

Now to get the process back, you must sent a `SIGCONT` signal to it.

This can be done with:

    kill -cont %%

which will leave the process on background.

The exact same can be achieved with:

    bg

Another possibility is:

    fg

which does the same as `kill -cont %%` but puts the process on the foreground.

`<C-Z>` + `bg` is a very useful combo to recover when you launched a GUI application without `&` and you want to use the terminal again. For example, if you enter:

    firefox

Firefox runs, but you can't use the terminal anymore.

To correct this, just do: `<C-Z>` + `bg`, and it is now running on the background!

Next time, just don't forget to do:

    firefox &

### c-s

Like `<C-Z>`, send `SIGSTOP` to foreground process.

Unlike `<C-Z>`, does not put process on the background.

Run:

    seqs

Enter `<C-Z>`. The process stops, but the terminal is useless since it is still on foreground.

The process can be resumed with `<C-Q>`.

### c-q

Send a `SIGCONT` to foreground process.

Useful after a `<C-S>`.

### c-d

Send EOF to pipe.

Often stdin input ends at the first newline.

But if you want to be able to give newlines, you have to enter a `<C-D>` to end the input.

TODO add an example, maybe with `cat`.

### c-?

Clear line.

### c-h

Destructive backspace.

### c-j

Newline `\n` char.

### Carriage return

### c-m

Carriage return.

`printf` backslash escape: `\r`.

Literal with `<c-v><enter>`.

Try it out:

    printf '0123\r45\n'

You should see on your terminal exactly `4523`, as the `01` got overwritten.

### c-[

Same as ESC. Try `<c-v><esc>`.

Type `asdf`. Type `c-h`. terminal removes the `f`.

### c-v c-X

Input a literal control char `c-x`, bypassing any special meaning.

To input some literal control chars that have special no meaning you can just type them directly. Ex: c-a.

To input any literal control chars including those do that have special meaning like `c-c` use `<c-v>` before them, so for example: `<c-v><c-c>`.

Control chars <c-x> are represented as `^X` on the terminal.

Note however that while visually indistinguishable from a literal `^X`, it is only a single char, since backspacing remove the `^X` at once.

To view the ASCII value of a sequence:

    echo -n <c-v>SEQ | hedump -C

When you press a key, X tells the terminal about the key press, and the terminal decides what to do with it.

The typical thing that happens is that some program is reading from the terminal (bash shell, sh shell, python shell, etc.)

What the terminal does on key presses is not officially standardized but the VT100 behavior became the de facto standard <http://en.wikipedia.org/wiki/VT100> so this is what computer terminal programs emulate. VT100 uses ASCII values only (0-127) with Ctrl + keys to reach the non alphanumerical values.

### Null character

TODO how to insert a literal null character? The usual representation is `^@`, but hitting `<c-v><c-s-2>` and variants did not work for me.

## ANSI escape codes

The VT100 can also stuff that have no ASCII value like:

- arrow keys
- Fn keys
- setting colors and other text attributes
- setting cursor position

To achieve those goals it uses standardized ANSI escape codes <http://en.wikipedia.org/wiki/ANSI_escape_code> which are also based on ASCII.

To use ANSI escape seriously and in a more portable and clear way, use `tput` instead of raw ANSI escape codes.

It is however better to understand the low level ANSI escape codes before moving to the higher level `tput`.

### Text attributes

ANSI codes allow one to control text attributes such as color and font.

The amount of available attributes is very restricted if compared with modern toolkits such as GTK (there are only 8 colors and very few fonts), but is has proved to be enough even for complex curses GUIs such as VIM.

The following example prints:

- a red and underlined `a` character
- a red and bold `b` character
- a `c` character with default attributes:

        printf '\033[4;31ma\033[1;24mb\033[0mc\n'

Which can be broken up as:

     \033 [ 4 ; 31 m | a | \033 [ 1 ; 24 m  | b | \033 [ 0 m | c
     ^^^^^^ ^ ^ ^^ ^ |   |        ^   ^^    |   |            |
     1      2 3 4  5 |   |        6   7     |   |            |

where:

1. CSI
2. underline on
3. separator
4. red
5. SGR
5. bold
6. underline off

How it works:

-   `\033`: `\0` tells `printf` that a octal character value is comming up.

    So `\033` tells `printf` to print byte 033 (octal) to screen, which corresponds to the ASCII character `ESC`.

    Instead of `\033` you could also type:

        echo <C-V><C-[>[31ma

    where `<C-V>` is how to tell the terminal to add a literal `<C-[>` (ESC) character to the input.

    This shows up on the terminal as:

        echo ^[[31ma

    where `^[` is way the terminal represents the ESC byte on inputs,

-   `[` after the `ESC` byte is the way ANSI specifies that all escape sequences should begin.

    This pair is called a CSI (Control Sequence Introducer).

    The `ESC` byte is so named because it starts ANSI escape sequences.

-   Now that the terminal saw a CSI, it starts interpreting attributes.

    The `m` at `4;31m` says that `4;31` are Select Graphical Rendition parameters (SGR) which as the name indicates control how the text is rendered to screen.

    Finally `4;31` means that there are two SGR parameters:

    - `4`   which means underline
    - `31`  which means red

    and the semicolon `;` is just a separator.

    Other SGR params used are:

    - `1`:  bold
    - `24`: underline off
    - `0`:  remove all format

    Note how each escape sets the *current* value for an attribute.

    In this way, the red attribute goes for both `a` and `b`, until it is turned off for `c`.

    The list of all possible SGR parameters and can also be at [this wiki page](wiki-ansi-escape).

    Besides `m`, there are many other possible characters, which have different effects. The list of all characters can be found at [wiki-ansi-escape][].

### Cursor position

You can also set cursor position by outputting special control strings to stdout.

Move cursor to position 2,3 on terminal:

    echo -e '\033[2;3H'

H is the command to position the cursor called `CUP`, 2;3 is the position.

Move the cursor back one position (same as left arrow):

    echo -e 'a\033[1Db'

which shows `b` on the terminal, since a was overwritten by b!

Move cursor up four times:

    echo -e '000\033[4A111'

Things will get really; ugly as you start to rewrite previous `PS1`, `PS2` and stdout.

This should rarely be piped to other programs, only given to terminals otherwise all those ugly chars will go to the pipe! Programs that color stuff should always test if output is going to a pipe or not.

## Canonical vs non canonical

Canonical waits for newline to make data available to program, non canonical does not.

<http://stackoverflow.com/questions/358342/canonical-vs-non-canonical-terminal-input>

## General operation

The terminal is a GUI between the user and the system.

### Terminals work with bytes

VT100 works only with ASCII values as input and outputs (in range 0 - 127) with control + keys to reach the non alphanumerical values as shown at: <http://en.wikipedia.org/wiki/ASCII>. This allows all the 0 - 127 range to be reached.

Certain key presses cannot be translated into single bytes, for example a left arrow, but may be translated into ANSI escape codes, which are multibyte sequences that the terminal can interpret correctly to do what it meant to, in this case move the cursor to the left.

Current terminal emulators may however accept any bytes as input, and even display those bytes correctly supposing a given encoding (usually UTF-8).

### Input

As any GUI, the terminal takes user input, takes actions, and gives the user output.

On original terminals, pressing certain keys would generate electric signals which corresponded directly to certain predefined bytes.

On terminal emulators, when the user enters a key, the X window system passes the key presses to the terminal emulator, which in turn converts those key presses into bytes in a way that resembles the operation of the original terminals.

For example, is the user presses `a`, X tells this to the emulator, which in turn interprets this as the ASCII byte with value 97.

There are two basic types of actions that the terminal emulator can make when it receives a byte:

-   most bytes such as alphanumeric are accumulated in a buffer and printed to the screen.

-   when certain special bytes are received, known as control bytes, the terminal takes more complex actions.

    The most basic and by far important control character is the carriage return or the newline, both of which can be generated via an `<enter>` keypress.

    The action to take in these cases is to add a newline to the end of the buffer, and make the accumulated bytes available a shell interpreter such as `sh`.

    To do so, it puts those bytes on the write side of a pipe, which the interpreter reads from the read side.

    When the interpreter is done, it reads again from the pipe, which is now empty, so it blocks until data becomes available.

The above actions also depend if the terminal is on canonical or non canonical mode.

### Output

The terminal must also decide what to do with the stdout generated by the interpreter.

The most common action is to print every byte to the screen as the corresponding ASCII char, but there are a few exceptions:

-   control characters.

    Some of them have visual representations, such as `\t` which prints a tab of `\n`, but others do not.

    `^A` is a very special case. It is called beep char, and if configured to do so, terminals may emit a beep when they see this at stdout. try (you must do `<c-v><c-a>`, not copy paste...):

        echo ^A

    This may not be enabled by default on certain terminal emulators.

    Furthermore, the terminal may represent characters differently if they are input or output characters.

    For example, type:

        echo a<C-V><C-C>b

    The input line shows:

        echo a^Cb

    where `^C` is a conventional representation of control characters, and therefore represents ASCII value 3.

    However the output may look something like:

        echo a?!*b

-   ANSI escape codes

    Must be interpreted to do all sorts of special things, such as move the cursor or cange colors.

## Terminal emulator vs sh interpreter

`sh` interpreters take raw text and do certain actions.

This raw text could come either from text files (scripts) or pipes, but in any case it is just raw text.

Terminal emulators are GUIs that interface with users in more complex ways.

It is easy to get the two mixed up because most of the time terminal emulators simply accumulate input chars, wait for an `<enter>` keypress, and then send strings to the sh interpreter.

## Good terminal emulators

`tmux` and `screen` are the most portable options, use those as much as possible instead of terminal emulator features.

Drop-down capability is a huge advantage: hit a key, and the terminal appears. Options:

-   `guake`: GNOME

-   `yakuake`: KDE

-   `finalterm` <https://github.com/p-e-w/finalterm> integrates with the interpreter it is running, offering features like:

    - drop-down list auto-completion
    - mouse click on ls items to `cd` into them

-   Terminator <https://launchpad.net/terminator> is a window splitter master, but `tmux` does everything it does and better.

Classics:

- <https://en.wikipedia.org/wiki/Rxvt-unicode>
- <https://en.wikipedia.org/wiki/Xterm>
- <https://en.wikipedia.org/wiki/Rxvt>

### Linux terminal

TODO check: terminal emulator provided by the Linux kenrel that runs directly inside a TTY.

TODO: source code location.

Ubuntu 15.10 Ctrl + Alt + F2-6.

`echo $TERM` gives `linux` TODO confirm: as can be seen from some boot methods that show a Penguin image.

## Image inside terminal

<http://askubuntu.com/questions/97542/how-do-i-make-my-terminal-display-graphical-pictures>

The Linux console has that capability through `fbi`.

[wiki-ansi-escape]: http://en.wikipedia.org/wiki/ANSI_escape_code

# Game

## Command line

### nethack

Most famous dungeon crawler.

Save is only pause: no return from death.

Many things kill you for totally unpredictable reasons.

### fortune

Tells you fortune to stdout!

    fortune

### cowsay

An ASCII art cow echoes stdin:

    echo a | cowsay
    echo b | cowsay

Combo with fortune:

    fortune | cowsay
    fortune | cowsay

### moon-buggy

Jump over craters and shoot forward:

    moon-buggy

### robotfindskitten

Cute!

    robotfindskitten

### bsdgames

Lots of console games/cute apps.

Highly recommended.

List games on Ubuntu:

    apt-file show bsdgames | grep /usr/games/

Review top 10: <http://techtinkering.com/2009/08/11/my-top-10-classic-text-mode-bsd-games/>

#### Adventure games

Computer RPGs.

Read the description of places and things.

Type what to do and where to go.

##### battlestar

##### adventure

##### phantasia

##### battlestar

#### backgammon

#### number

Convert number in numerals to number in English:

    [ `echo 1 | number` = "one." ] || exit 1

#### pom

Displays the phase of the moon.

#### rot13

    [ "$(echo 'abc' | rot13)" = 'nop' ] || exit 1

#### robots

Very simple, fun, but too much luck.

Play:

    robots

Play with better settings:

    alias robots="robots -ta`for i in {1..10000}; do echo -n n; done`"

#### atc

Nice timing memory.

`E1 A0` means: plane E1, will land at airport 0

    atc

List scenarios and leave:

    atc -l

Play a scenario:

    atc -g crossover

Cannot pause...

#### hack

Nethack predecessor.

    hack

#### hunt

Multiplayer shooter.

Looks *very* promising, but multiplayer only, and no online mode.

TODO architecture. Works over network? Someone is the server?

https://www.youtube.com/watch?v=HdcFWUuV6-Y

### gnugo

CLI go.

## netreck

2D non terminal spaceship mouse clicking online multiplayer classic.

## gnome

### golly

Conway's game of life simulator

Because the global menu does not work, deactivate it on Ubuntu:

    env UBUNTU_MENUPROXY=0 golly

### gnomine

Minesweeper clone

    gnomine

### Gnotski

Knotski clone.

    gnotski

No, Knotski has nothing to do with KDE =)

### four-in-a-row

Also known as connect four.

Warning: this games has been solved, so the program might do perfect play =)

## KDE

### kreversi

Reversi for KDE.

## fps

### Urban Terror

CS like, but mostly capture the flag.

Good inertia, not too fast.

Free but closed source.

### World of Padman

FPS, very large scenarios, cool weapons.

Too fast for my taste.

## clones

### Pingus

Lemmings clone.

Includes map designer.

### Hedgewars

Worms clone, has same feeling. Includes map builder.

### Super Maryo Chronicles

Super mario bros clone.

### Tux Kart

Mario Kart 64 clone.

## Strategy

### Battle for Wesnoth

Turn based unit control on 2D hexagonal map.

Very addictive and time consuming.

Open source, but could be a professionally made game: graphics, music and gameplay.

Includes a map designer.

## emulation

### NES

#### FCEUX

### SNES

#### zsnes

Features:

- fast forward
- states
- good ROM support

#### snes9x-gtk

Lag.

### Nintendo 64

#### mupen64plus

Features:

- fast forward
- states

Config only via text file: `~/.config/mupen64plus/`.

Defaults emulator:

    0-9       Select virtual 'slot' for save/load state (F5 and F7) commands
    F5        Save emulator state
    F7        Load emulator state
    F9        Reset emulator
    F10       slow down emulator by 5%
    F11       speed up emulator by 5%
    F12       take screenshot
    Alt-Enter Toggle between windowed and fullscreen
    p or P    Pause on/off
    m or M    Mute/unmute sound
    g or G    Press "Game Shark" button (only if cheats are enabled)
    / or ?    single frame advance while paused
    F         Fast Forward (playback at 250% normal speed while F key is pressed)
    [         Decrease volume
    ]         Increase volume

Defaults controller:

    Analog Pad              Arrow Keys (left, right, down, up)
    C Up/Left/Down/Right    "I", "J", "K", "L"
    DPad Up/Left/Down/Right "W", "A", "S", "D"
    Z trigger               "z"
    Left trigger            "x"
    Right trigger           "c"
    Start                   "Enter" ("Return")
    A button                "left shift"
    B button                "left control"
    Select Mempack          ","
    Select Rumblepack       "."

Keyboard: <http://code.google.com/p/mupen64plus/wiki/KeyboardSetup>

Usage:

    mupen64plus rom.v64

Full screen:

    alias mupen="mupen64plus --fullscreen"
    mupen rom.v64

### Game Boy Advance

#### VisualBoy Advance

Two versions: GTK or not. Take GTK.

Executable name: `gvba`.

Version 1.8.0 had the too fast bug:
<http://askubuntu.com/questions/62611/visual-boy-advanced-emulator-runs-too-fast>.
Seems unsolved.

#### mednafen

0.8.D.3 has not friendly configuration interface, but works well.

`F1` for options.

`Alt-Shift-1` to configure controller 1.

Backtick `` ` `` to fast forward.

Edit `~/.mednafen/mednafen.cfg` line `command.fast_forward` to  `command.fast_forward keyboard 32`.

`keyboard` values seems to follow <http://expandinghead.net/keycode.html>

### Nintendo DS

#### Desmume

Works very well.

- F1-9: load state
- shift + F1-9: save state
- space: play / pause

### PS1

#### pcsxr

### dosbox

Some good games there:

    cd
    mkdir dos
    dosbox game.exe

There are also `.bat` and `.com` executables.

Inside the emulator:

    mount c /home/$USER/dos
    c:
    dir
        #ls
    cd game
    game.exe

To avoid mounting every time, put under the `[autoexec]` section:

    echo -e "mount c /home/$USER/dos\nc:" >> ~/.dosbox/dosbox-*.conf

## Lists

<http://www.lgdb.org/>

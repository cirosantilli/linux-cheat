# console

nethack dungeon rpg

## fortune

tells you fortune to stdout!

    fortune
    fortune

## cowsay

an ascii art cow echoes stdin

    echo a | cowsay
    echo b | cowsay

combo with fortune:

    fortune | cowsay
    fortune | cowsay

## moon-buggy

simple, jump over obstacles

    moon-buggy

## robotfindskitten

cute!

    robotfindskitten

## bsdgames

lots of console games/cute apps

highly recommened

get a list of games:

    afsh bsdgames | grep /usr/games/

### battlestar

MUD

### backgammon

### number

convert number in numerals to number in english

    assert [ `echo 1 | number` = "one." ]

### pom

displays the phase of the moon

### primes

print primes between 1 to 100:

    primes 1 100

count primes:

    primes 1 100 | wc -l

### robots

simple, fun, a bit too much luck

play:
    robots

play with better settings:
    alias robots="robots -ta`for i in {1..10000}; do echo -n n; done`"

### atc

nice timing memory

`E1 A0` means: plane E1, will land at airport 0

    atc

list scenarios and leave:

    atc -l

play a scenario:

    atc -g crossover

cannot pause...

### hack

nethack predecessor

    hack

### hunt

multiplayer shooter

looks *very* promissing, but multiplayer only...

# netreck

2d spaceship battle multiplayer classic

# urban terror

counter strike clone. best fps game on linux

# golly

conways game of life simulator

because the global menu does not work, deactivate it on ubuntu:

    env UBUNTU_MENUPROXY=0 golly

minesweeper clone

    gnomine

# gnotski

knotski clone

    gnotski

# urban terror

my favorite linux free fps so far

cs like, but mostly capture the flag.

good inertia, not too fast.

free but closed source

# world of padman

fps, very large scenarios, cool weaponsmoves

but too fast for my taste.

# snes

## zsnes

features:

- fast forward
- states
- good rom support

# nintendo 64

## mupen64plus

mupen64plus features:

- fast forward
- states

keyboard: <http://code.google.com/p/mupen64plus/wiki/KeyboardSetup>

usage:

    mupen64plus rom.v64

fullscreen:

    alias mupen="mupen64plus --fullscreen"
    mupen rom.v64

# ps1

## pcsxr

# dosbox

some good games there

    cd
    mkdir dos
    dosbox game.exe

there are also `.bat` and `.com` executables

## inside the emulator

    mount c /home/$USER/dos
    c:
    dir
        #ls
    cd game
    game.exe

## avoid mouting every time

put under the `[autoexec]` section:

    echo -e "mount c /home/$USER/dos\nc:" >> ~/.dosbox/dosbox-*.conf

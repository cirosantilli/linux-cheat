#!/usr/bin/env bash

#Good GNOME terminal emulator.

#Features:

#- *drop down*: runs on hidden window hit <F12> by defualt to toogle visibility.

    #This means it is very fast to open it up since it is always running!

#- IPC

    #It is meant to run single instance, and has good IPC communication.

    #It is possible for example to open new tabs or toogle visibility from other shells.

## yakuake

    #KDE alternative.

    #Upsides 2013:

    #- split tabs

    #Downsides 2013:

    #- lacks IPC

function print_read_guake {
    printf "%s\n" "$*"
    read
    guake "$@"
}

echo "open new tab at given dir"
print_read_guake -n /usr/

echo "toogle visibility"
print_read_guake -t

echo "open preferences window"
print_read_guake -p

echo "select first tab"
print_read_guake -s 0
#it is always a number, not what is written on the tab

echo "get current tab number"
print_read_guake -g 
    #print cur tab

echo "exec string in current tab:"
print_read_guake guake -e cd
print_read_guake guake -e "cd / ; ls"

echo "rename cur tab in gui"
print_read_guake guake -r "new name"

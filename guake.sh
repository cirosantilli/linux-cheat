#!/usr/bin/env bash

#my currently preferred standalone terminal emulator:

    #sudo aptitude install -y guake

#so called *drop down*: runs on hidden window hit <F12> to toogle visibility

#single instance, great ipc communication

    # this means it is very fast to open new tabs on it
    # since it is always running!

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

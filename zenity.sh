#!/usr/bin/env bash

# One-liner GUI prompts from bash!

# More powerful fork: `YAD` (as of 2014 needs an extra PPA).

# Create ncurses dialogs: dialog. Pretty useless since only allows for a single input,
# so stdin is more useful.

# yes/no question
if zenity --question --text="abc"; then
  zenity --info --text="yes\!"
else
  zenity --error --text="no\!"
fi

# warning
zenity --warning --text "1"

# error
zenity --error --text "1"

# info dialog (show some text only)
zenity --info --text "Join us at irc.freenode.net #lbe."

# text input prompt
a="$(zenity --entry --text "1" --entry-text "2" --entry --text "3" --entry-text "4" )"
echo "$a"

# multiple fields table text input
zenity --list --text "1" --column "2" --print-column=2 --multiple --column "3" --editable "4" "5" "6" "7" "8" ""

# non editable text box:
seq 1 30 | zenity --text-info --width 400 --height 300

# radio list
a="$(zenity --list --text "1" --radiolist --column "2" --column "3" TRUE Amazing FALSE Average FALSE "4" FALSE "5")"
echo "$a"

# selectable list:
a="$(seq 1 30 | zenity --list --column "1")"
echo selectable list: "$a"

# check list
a="$(zenity --list --text "1" --checklist --column "2" --column "3" TRUE "4" TRUE "5" FALSE "6" FALSE "7" --separator=":")"
echo "$a"

# file selection
a="$(zenity --file-selection --save --confirm-overwrite)"
echo "$a"

# progress dialog
#gksudo lsof | tee >(zenity --progress --pulsate) >lsof.txt

# scale dialog
a="$(zenity --scale --text "1" --min-value=2 --max-value=100 --value=2 --step 2)"
echo "$a"

exit 0

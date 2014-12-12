#!/usr/bin/env bash

#get/set terminal output params like colors or line position
#in a portable and clear way

#could be used for curses interface

#get width:

    tput cols

#get terminal height:

    tput lines
    
#clear terminal:

    tput clear
    read

#clear comes on the same package TODO confirm

    clear

#go to top of screen
#start rewritting over what was written

    tput cup 0 0

#multiple commands

    echo $'clear\ncup 10 0' | tput -S

## colors

    CLEAR_TERMINAL=`tput clear`

    SET_CURSOR_POSITION=`tput cup 2 3`
    tput sc #saves current position
    tput rc #restore previously saved cursor position

    NCOLS=`tput cols`
    NLINES=`tput lines`

    CLEAR_FORMAT=`tput sgr0`

    HIDE_CURSOR=`tput civis`
    SHOW_CURSOR=`tput cnorm`

    BOLD=`tput bold`

    UNDERLINE_ON=`tput smul`
    UNDERLINE_OFF=`tput rmul`

    LINE_WRAP_OFF=`tput rmam`
    LINE_WRAP_ON=`tput smam`

    Black="$(tput setaf 0)"
    BlackBG="$(tput setab 0)"

    Red="$(tput setaf 1)"
    RedBG="$(tput setab 1)"

    Green="$(tput setaf 2)"
    GreenBG="$(tput setab 2)"

    Brown="$(tput setaf 3)"
    BrownBG="$(tput setab 3)"

    Blue="$(tput setaf 4)"
    BlueBG="$(tput setab 4)"

    Purple="$(tput setaf 5)"
    PurpleBG="$(tput setab 5)"

    Cyan="$(tput setaf 6)"
    CyanBG="$(tput setab 6)"

    White="$(tput setaf 7)"
    WhiteBG="$(tput setab 7)"

    echo "${GreyBG}${Red}gray on red${CLEAR_FORMAT}no format"
    tput bold; tput setaf 7; tput setab 1; echo "gray on red"; tput sgr0; echo "no format"

    #colors
    #Set background color 	tput setab color
    #Set foreground color 	tput setaf color
    #Set bold mode 	tput bold
    #Set half-bright mode 	tput dim
    #Set underline mode 	tput smul
    #Exit underline mode 	tput rmul
    #Reverse mode 	tput rev
    #Set standout mode 	tput smso
    #Exit standout mode 	tput rmso
    #Reset all attributes 	tput sgr0
    #Color 	Code
    #black 	0
    #red 	1
    #green 	2
    #yellow 	3
    #blue 	4
    #purple 	5
    #cyan 	6
    #white 	7o

## setterm

    #outputs stdout that changes terminal properties

    #in same package as tput

    #turns the cursor on/off:

        setterm -cursor off
        setterm -cursor on

#!/usr/bin/env bash

#TODO convert to a proper .md since this is never going to be runnable

#real name: X Window System

#x11 is a `window system`

#upcoming alternative: wayland
#not yet widely used,
#but plans made for use in Ubuntu

#x11 is only an interface.
#there can be different implementations:
	#`X.org` implentation currently dominates
	#`XFree86` was the dominant prior to 2004
		#it broke glp, and fell into disgrace

##it is an abstraction layer for things like:

	#windows
		#stack access order for alt tab
	#key presses
	#mouse position / presses
	#screen backlight

#it is usually graphic accelerated
#this is why messing with gpu settings may break your desktop =)

##it does not include things like:

	##x display management
		#a graphical login screen
		#choice of window manager
		#some implementations:
			#LightDM (lightweight), ubuntu
			#KDM, kde
			#GDM (gnome) fedora

	##`x window manager`:
		#functions:
			#window switching (alt tab / visible list of open windows)
			#program opening with button clicks
				#dock
				#dash
			#multiple desktops
		#implementations:
			#metacity
			#compiz

	#sound management
		#this has been taken up by several related projects:
			#PulseAudio
			#Advanced Linux Sound Architecture (ALSA)

#it uses a server/client mode
#client and server can be on different machines
	#client:
		#typically programs with a window
		#clients give commands to the xserver and tell it to draw on screen
		#clients respond to input events via callback functions
	#server:
		#creates the image
		#sends inputs events to clients who responds to it via callbacks
		#a server has many displays
		#a display has many screens, one mouse and one keyboard
		#to set the display to use use the DISPLAY var:
			export DISPLAY=localhost:0.0
			DISPLAY=localhost:0.1 firefox & #single commena
				#0.1 means: display 0, screen 1

##higher level apis

	#for higher level APIs, use toolkits:

	#gtk: primarily for x11, but can be cross platform
	#qt

	##gtk

		gtk-demo
			#very nice demo of lots of 2.0 features with easy to see source code

##xorg

	#is the dominant implementation of the x server

	##conf file

		man xorg.conf

		#first of:
			#/etc/X11/<cmdline>
			#/tmp/Xorg-KEM/etc/X11/<cmdline>
			#/etc/X11/$XORGCONFIG
			#/tmp/Xorg-KEM/etc/X11/$XORGCONFIG
			#/etc/X11/xorg.conf-4
			#/etc/X11/xorg.conf
			#/etc/xorg.conf

			#where <cmdline> is specified on the command line at startup

	##log file

		less /var/log/Xorg.0.log
		#                 ^
		#0: display number

##X

	#get xserver version

	sudo X -version

##xhost

	#x control

##service lightdm

	sudo restart lightdm
		#restart lightdm display manager used for Unity

		#restart X too

		#closes all your programs

		#do this on a tty, not on an xterminal
		#don't ask me why! =), but probably because
		#your terminal is going to die in the middle of the operation

	sudo stop lightdm

	sudo start lightdm

#starts x, somewhere

	startx

##xlsclients

	#list x clients
	#this allows you to see all windows

	xlsclients
	xlsclients -l
		#more info

#xprop

	#get window info

	xprop -name Krusader
		#-name: select by name
		#-id: select by id
	xprop -spy -name Krusader

#xmodmap

	#modify key maps

	f=~/.Xmodmap
	echo "! Swap caps lock and escape
remove Lock = Caps_Lock
keysym Escape = Caps_Lock
keysym Caps_Lock = Escape
add Lock = Caps_Lock
" >> "$f"
	xmodmap "$f"
		#esc and caps lock are changed!

	echo "xmodmap \"$f\"
" >> ~/.xinitrc
			#~/.xsession could also be used depending on system
	chmod +x ~/.xinitrc
		#now the change will happen every time at startup

##xdotool

	#send clicks and manage window properties.

	#select window

		#if no selector given, act on cur

		id=
		xdotool search --window "$id" key ctrl+c
			#to a window id

		n=
		xdotool search --name "$n" key ctrl+c
			#all windows with given name
			#this is exactly what is shown on window titlebar

	#keystrokes

		xdotool key a
			#send a to cur window
		xdotool key a b
			#send a then b to cur window
		xdotool key F2
			#send F2 to cur window
		xdotool key Aacute
			#send á to cur window
		xdotool key ctrl+l
			#send ctrl+l to cur window

	#key:     up and down
	#keydown: only down
	#keyup:   only up

		xdotool type 'ab cd'
			#sends a then b then space then c then d
		xdotool type --delay 1 'ab'
			#key a, waits 1 ms then key b

	#sync
		google-chrome &
		xdotool search --sync --onlyvisible --class "google-chrome"
			#wait until results
			#you can launch an app and send commands, making sure they will be received!

##keyboard and mouse automation

	#autokey: high level, gui interface x11 automation

##xbacklight

	#control screen brightness

	xbacklight -get
		#see current
	xbacklight -set 80
		#set to 80%

##xsel

	#manipulate the x selection and clipboard

	##x selection

		#is the last focused selected text

		#can be pasted with a middle click

		echo a | xsel
			#set x selection
		assert [ `xsel` = a ]
			#print contents of xselection

	##clipboard

		#uses the clipboard (ctrl+c) instead of selection

		echo a | xsel -b
			#set clipboard
		assert [ `xsel -b` = a ]
			#print clipboard

	##append

		echo a | xsel
		echo b | xsel -a
		assert [ "`xsel`" = $'a\nb\n' ]

	##follow

		#follows stardard input as it grows

		echo a > f
		xsel -f < f
		assert [ "`xsel`" = $'a\n' ]
		echo b >> f
		assert [ "`xsel`" = $'a\nb\n' ]

		##stop

			echo a | xsel
			echo c > f
			assert [ "`xsel`" = $'a\n' ]

##xmodmap

	#view and modify key mappings

	xmodmap -pke > ~/.Xmodmap
		#outpus all keymappings to a file
		#
		#keycode  24 = q Q q Q adiaeresis Adiaeresis
		#              ^ ^ ^ ^ ^^^^^^^^^^ ^^^^^^^^^^
		#              1 2 3 4 5          6
		#
		#1: no modifiers
		#2: shift
		#3: mode_switch no shift
		#4: mode_switch +  shift
		#5: ?
		#6: ?
		#7: ?
		#8: ?
		#9: ?
		#
		#**AltGru** is the mode_switch key
		#
		#up to 8 keysims bay be attached to each keycode
		#
		#however, only the first 4 are commonly used

##xeyes

	#fun x11 test prog

	xeyes

##xev

	#opens test window and prints x events description to stdout

	xterm
		#does not work well on guake
	xev

##xwd

	#take screenshots (x11 write dump)

	xwd -root -out a.xwd
		#take screenshot of all windows
	xwd -out a.xwd
		#wait for mouse click
		#take screenshot of clicked window only
	xwd | xwdtopnm | pnmtopng > Screenshot.png
		#change format

##wmctrl

	wmctrl -m
		#detect

##display manager

	cat /etc/X11/default-display-manager
		#detect which

	#lightdm

		echo $GDMSESSION
			#tells option chosen from login screen

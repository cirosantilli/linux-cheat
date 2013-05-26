#!/usr/bin/env bash

#do those annoying popup notifications yourself!

#install:

    #sudo aptitude install -y libnotify-bin

#basic usage:

    notify-send a

#-t: timeout:

    notify-send -t 1000 b

#-u urgency. low, normal, or critical:

    notify-send -u critical c

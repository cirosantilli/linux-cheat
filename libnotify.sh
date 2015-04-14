#!/usr/bin/env bash

# Do those annoying popup notifications yourself!

# Install:

    #sudo aptitude install -y libnotify-bin

# Basic usage:

    notify-send a

# -t: timeout:

    notify-send -t 1000 b

# -u urgency. low, normal, or critical:

    notify-send -u critical c

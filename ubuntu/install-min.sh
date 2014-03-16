#!/usr/bin/env bash

# Minimal bootup install inscript that I want to run on every new machine.

sudo apt-get update
sudo apt-get install -y aptitude

sudo aptitude install -y guake

sudo aptitude install -y vim
sudo aptitude install -y vim-gtk

sudo aptitude install -y krusader
sudo aptitude install -y konsole
sudo aptitude install -y kwalletmanager

sudo aptitude install -y pidgin
sudo aptitude install -y skype
# Google Talk
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo aptitude update
sudo aptitude install -y google-talkplugin

sudo aptitude install -y xsel
sudo aptitude install -y wmctrl

sudo aptitude install -y okular okular-extra-backends

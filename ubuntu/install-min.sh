n#!/usr/bin/env bash

# GUI utils survival kit. Terminal only in `install-min-ssh`.

# SSH suitable utils
  ./install-min-ssh.sh

# Terminal
  sudo aptitude install -y guake

# Editor
  sudo aptitude install -y vim-gtk

# File manager
  sudo aptitude install -y krusader
  sudo aptitude install -y konsole
  sudo aptitude install -y kwalletmanager

# PDF
  sudo aptitude install -y okular okular-extra-backends

# Communication
  sudo aptitude install -y pidgin
  sudo aptitude install -y skype
  # Google Talk
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo aptitude update
	sudo aptitude install -y google-talkplugin

sudo aptitude install -y xsel
sudo aptitude install -y wmctrl

#!/usr/bin/env bash

# Terminal only utils survival kit, suitable for SSH access.

# Package manager
	sudo apt-get update
	sudo apt-get install -y aptitude

# Dotfiles:
	sudo aptitude install -y git
  git clone https://github.com/cirosantilli/dotfiles
  cd dotfiles
  ./install.sh

# Editor
	sudo aptitude install -y vim
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim +PluginInstall +qall

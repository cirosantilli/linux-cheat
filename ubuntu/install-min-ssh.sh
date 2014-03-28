#!/usr/bin/env bash

# Terminal only utils survival kit, suitable for SSH access.

# Package manager
	sudo apt-get update
	sudo apt-get install -y aptitude

# Dotfiles:
	git clone https://github.com/cirosantilli/dotfiles
	cd dotfiles
	./here-ln-home.sh

# Editor
	sudo aptitude install -y vim git
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim +PluginInstall +qall

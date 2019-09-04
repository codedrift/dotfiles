#!/bin/bash

function link() {
	echo "Linking $1 to $2"
	ln -sf $1 $2
}

function linkToHome() {
	link $PWD/$1 $HOME/$1
}

function gitClone(){
	if [ ! -d "$2" ]; then
		echo "Cloning $1 to $2"
		git clone $1 $2
	else
    	echo "Skipping $1. Folder $2 exists."
	fi
}


gitClone https://github.com/zplug/zplug ~/.zplug

linkToHome .zshrc
# linkToHome .vimrc
linkToHome .zshenv
linkToHome .zsh
linkToHome .phoenix.js

#linkToHome .hyper.js

link $PWD/terminator $HOME/.config/

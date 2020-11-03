#!/bin/bash

link () {
	echo "Linking $1 to $2"
	ln -sf $1 $2
}

linkToHome() {
	link $PWD/$1 $HOME/$1
}

gitClone(){
	if [ ! -d "$2" ]; then
		echo "Cloning $1 to $2"
		git clone $1 $2
	else
    	echo "Skipping $1. Folder $2 exists."
	fi
}


gitClone https://github.com/zplug/zplug ~/.zplug

linkToHome .zshrc
linkToHome .vimrc
linkToHome .zshenv
linkToHome .zsh

touch $HOME/.zsh_local

#linkToHome .hyper.js

link $PWD/terminator $HOME/.config/

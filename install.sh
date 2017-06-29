#!/bin/bash

sudo ln -sf $PWD/.zshrc $HOME/.zshrc
sudo ln -sf $PWD/.zshenv $HOME/.zshenv
sudo ln -sf $PWD/.vimrc $HOME/.vimrc

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sudo ln -sf $PWD/.tmux.conf $HOME/.tmux.conf
sudo ln -sf $PWD/.i3 $HOME/.i3
sudo ln -sf $PWD/alacritty.yml $HOME/alacritty.yml

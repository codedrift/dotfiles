#!/bin/bash

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sudo ln -s $PWD/.tmux.conf $HOME/.tmux.conf
sudo ln -s $PWD/launch.sh $HOME/launch.sh

#!/bin/bash

alacritty -e tmux new-session -s $$
tmux kill-session -t $$;

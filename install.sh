#!/bin/bash

mkdir $HOME/.backup
CONFIG=$(pwd)

mv ~/.config/nvim $HOME/.backup/
ln -s $CONFIG/nvim/ $HOME/.config/nvim

mv ~/.config/alacritty $HOME/.backup/
ln -s $CONFIG/alacritty/ $HOME/.config/alacritty

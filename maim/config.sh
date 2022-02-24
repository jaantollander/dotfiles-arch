#!/bin/bash
mkdir -p $HOME/screenshots
mkdir -p $XDG_CONFIG_HOME/maim

mkdir -p $XDG_CONFIG_HOME/i3/include
ln -sf $DOTFILES/maim/config/i3.conf $XDG_CONFIG_HOME/i3/include/maim.conf

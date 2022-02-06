#!/bin/bash
mkdir -p $HOME/screenshots
mkdir -p $XDG_CONFIG_HOME/maim
ln -sf $DOTFILES/maim/config/i3.conf $XDG_CONFIG_HOME/maim/i3.conf

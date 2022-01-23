#!/bin/bash

# TODO: set directory location as environment variable?
# TODO: make directory for screenshots

mkdir -p $XDG_CONFIG_HOME/scrot
ln -sf $DOTFILES/scrot/config/i3.conf $XDG_CONFIG_HOME/scrot/i3.conf

mkdir -p $HOME/screenshots

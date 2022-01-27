#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/udiskie
ln -sf $DOTFILES/udiskie/config/config.yml $XDG_CONFIG_HOME/udiskie/config.yml
ln -sf $DOTFILES/udiskie/config/i3.conf $XDG_CONFIG_HOME/udiskie/i3.conf

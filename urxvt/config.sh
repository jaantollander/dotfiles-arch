#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/urxvt
ln -sf "$DOTFILES/urxvt/config/urxvt.xresources" "$XDG_CONFIG_HOME/urxvt/urxvt.xresources"

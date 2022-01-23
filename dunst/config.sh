#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/config/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"
ln -sf $DOTFILES/dunst/config/i3.conf $XDG_CONFIG_HOME/dunst/i3.conf

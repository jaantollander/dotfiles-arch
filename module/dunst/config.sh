#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/config/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"

mkdir -p "$XDG_CONFIG_HOME/i3/include"
ln -sf "$DOTFILES/dunst/config/i3.conf" "$XDG_CONFIG_HOME/i3/include/dunst.conf"

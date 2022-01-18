#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/config/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"

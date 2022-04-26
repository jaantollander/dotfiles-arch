#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/udiskie"
ln -sf "$DOTFILES/udiskie/config/config.yml" "$XDG_CONFIG_HOME/udiskie/config.yml"

mkdir -p "$XDG_CONFIG_HOME/i3/include"
ln -sf "$DOTFILES/udiskie/config/i3.conf" "$XDG_CONFIG_HOME/i3/include/udiskie.conf"

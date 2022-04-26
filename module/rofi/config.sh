#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/rofi"
ln -sf "$DOTFILES/rofi/config/config.rasi" "$XDG_CONFIG_HOME/rofi/config.rasi"

mkdir -p "$XDG_CONFIG_HOME/i3/include"
ln -sf "$DOTFILES/rofi/config/i3.conf" "$XDG_CONFIG_HOME/i3/include/rofi.conf"

#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/rofi"
ln -sf "$DOTMODULE/rofi/config/config.rasi" "$XDG_CONFIG_HOME/rofi/config.rasi"

mkdir -p "$XDG_CONFIG_HOME/i3/include"
ln -sf "$DOTMODULE/rofi/config/i3.conf" "$XDG_CONFIG_HOME/i3/include/rofi.conf"

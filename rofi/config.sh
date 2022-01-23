#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/rofi"
ln -sf "$DOTFILES/rofi/config/config.rasi" "$XDG_CONFIG_HOME/rofi/config.rasi"
ln -sf $DOTFILES/rofi/config/i3.conf $XDG_CONFIG_HOME/rofi/i3.conf

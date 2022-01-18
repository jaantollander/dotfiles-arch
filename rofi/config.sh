#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/rofi"
ln -sf "$DOTFILES/rofi/config/config.rasi" "$XDG_CONFIG_HOME/rofi/config.rasi"

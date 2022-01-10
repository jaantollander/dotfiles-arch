#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/rofi"
ln -sf "$DOTFILES/rofi/config.rasi" "$XDG_CONFIG_HOME/rofi/config.rasi"

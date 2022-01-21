#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/xrandr"
ln -sf "$DOTFILES/xrandr/config/external.sh" "$XDG_CONFIG_HOME/xrandr/external.sh"
ln -sf "$DOTFILES/xrandr/config/laptop.sh" "$XDG_CONFIG_HOME/xrandr/laptop.sh"

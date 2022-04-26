#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/X11/xrandr"
ln -sf "$DOTFILES/thinkpad_t480s/config/xrandr/external.sh" "$XDG_CONFIG_HOME/X11/xrandr/external.sh"
ln -sf "$DOTFILES/thinkpad_t480s/config/xrandr/laptop.sh" "$XDG_CONFIG_HOME/X11/xrandr/laptop.sh"

mkdir -p "$XDG_CONFIG_HOME/i3/include"
ln -sf "$DOTFILES/thinkpad_t480s/config/i3.conf" "$XDG_CONFIG_HOME/i3/include/xrandr.conf"

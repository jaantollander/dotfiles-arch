#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/X11"
ln -sf "$DOTFILES/X11/xinitrc" "$XDG_CONFIG_HOME/X11/.xinitrc"
ln -sf "$DOTFILES/X11/Xresources" "$XDG_CONFIG_HOME/X11/.Xresources"
ln -sf "$DOTFILES/X11/monitor_external.sh" "$XDG_CONFIG_HOME/X11/monitor_external.sh"
ln -sf "$DOTFILES/X11/monitor_laptop.sh" "$XDG_CONFIG_HOME/X11/monitor_laptop.sh"

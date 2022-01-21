#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/X11"
ln -sf "$DOTFILES/X11/config/xinitrc" "$XDG_CONFIG_HOME/X11/.xinitrc"
ln -sf "$DOTFILES/X11/config/xresources" "$XDG_CONFIG_HOME/X11/.Xresources"

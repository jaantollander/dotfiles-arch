#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/X11"
ln -sf "$DOTFILES/xorg/config/xinitrc" "$XDG_CONFIG_HOME/X11/.xinitrc"
ln -sf "$DOTFILES/xorg/config/style.xresources" "$XDG_CONFIG_HOME/X11/style.xresources"

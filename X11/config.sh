#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/X11"
ln -sf "$DOTFILES/X11/config/xinitrc" "$XDG_CONFIG_HOME/X11/.xinitrc"
ln -sf "$DOTFILES/X11/config/style.xresources" "$XDG_CONFIG_HOME/X11/style.xresources"
ln -sf "$DOTFILES/X11/config/urxvt.xresources" "$XDG_CONFIG_HOME/X11/urxvt.xresources"

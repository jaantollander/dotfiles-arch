#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/X11/xinitrc"
ln -sf "$DOTMODULE/urxvt/config/urxvt.xresources" "$XDG_CONFIG_HOME/X11/xinitrc/urxvt.xresources"
ln -sf "$DOTMODULE/urxvt/config/xinitrc.sh" "$XDG_CONFIG_HOME/X11/xinitrc/urxvt.sh"

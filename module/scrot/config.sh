#!/usr/bin/env sh
mkdir -p "$HOME/screenshots"
mkdir -p "$XDG_CONFIG_HOME/scrot"
ln -sf "$DOTMODULE/scrot/config/i3.conf" "$XDG_CONFIG_HOME/scrot/i3.conf"

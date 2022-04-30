#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/i3"
mkdir -p "$XDG_CONFIG_HOME/i3/include"
ln -sf "$DOTMODULE/i3/config/config" "$XDG_CONFIG_HOME/i3/config"

mkdir -p "$XDG_CONFIG_HOME/X11"
ln -sf "$DOTMODULE/i3/config/start.sh" "$XDG_CONFIG_HOME/X11/start_gui.sh"

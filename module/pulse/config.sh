#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/pulse"

mkdir -p "$XDG_CONFIG_HOME/i3/include"
ln -sf "$DOTMODULE/pulse/config/i3.conf" "$XDG_CONFIG_HOME/i3/include/pulse.conf"

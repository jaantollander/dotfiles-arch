#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/i3status"
ln -sf "$DOTMODULE/i3status/config/config" "$XDG_CONFIG_HOME/i3status/config"

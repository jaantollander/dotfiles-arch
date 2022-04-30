#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/bat"
ln -sf "$DOTMODULE/bat/config/bat.conf" "$XDG_CONFIG_HOME/bat/config"

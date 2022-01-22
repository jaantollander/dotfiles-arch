#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/i3"
ln -sf "$DOTFILES/i3/config/config" "$XDG_CONFIG_HOME/i3/config"
ln -sf "$DOTFILES/i3/config/status.conf" "$XDG_CONFIG_HOME/i3/status.conf"

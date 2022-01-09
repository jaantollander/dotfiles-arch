#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/i3"
ln -sf "$DOTFILES/i3/config" "$XDG_CONFIG_HOME/i3/config"
ln -sf "$DOTFILES/i3/i3status.conf" "$XDG_CONFIG_HOME/i3/i3status.conf"

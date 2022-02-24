#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/i3"
mkdir -p "$XDG_CONFIG_HOME/i3/include"
ln -sf "$DOTFILES/i3/config/config" "$XDG_CONFIG_HOME/i3/config"

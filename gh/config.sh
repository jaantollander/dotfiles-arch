#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/gh"
ln -sf "$DOTFILES/gh/config.yml" "$XDG_CONFIG_HOME/gh/config.yml"

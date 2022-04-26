#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/gh"
ln -sf "$DOTFILES/github/config/config.yml" "$XDG_CONFIG_HOME/gh/config.yml"

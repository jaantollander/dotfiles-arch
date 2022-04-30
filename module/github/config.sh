#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/gh"
ln -sf "$DOTMODULE/github/config/config.yml" "$XDG_CONFIG_HOME/gh/config.yml"

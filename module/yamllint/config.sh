#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/yamllint"
ln -sf "$DOTMODULE/yamllint/config/config.yaml" "$XDG_CONFIG_HOME/yamllint/config"

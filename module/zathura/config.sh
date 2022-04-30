#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/zathura"
ln -sf "$DOTMODULE/zathura/config/zathurarc" "$XDG_CONFIG_HOME/zathura/zathurarc"

#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/zsh/interactive"
ln -sf "$DOTMODULE/bd/config/@interactive.zsh" "$XDG_CONFIG_HOME/zsh/interactive/bd.zsh"

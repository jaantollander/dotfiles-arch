#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$DOTFILES/git/config/config" "$XDG_CONFIG_HOME/git/config"

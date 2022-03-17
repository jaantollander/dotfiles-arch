#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$DOTFILES/git/config/config" "$XDG_CONFIG_HOME/git/config"

mkdir -p $XDG_CONFIG_HOME/shell/interactive
ln -sf $DOTFILES/git/config/interactive.sh $XDG_CONFIG_HOME/shell/interactive/git.sh

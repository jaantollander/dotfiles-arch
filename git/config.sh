#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$DOTFILES/git/config/config" "$XDG_CONFIG_HOME/git/config"
ln -sf $DOTFILES/git/config/aliases.sh $XDG_SCRIPTS_HOME/git-aliases.sh

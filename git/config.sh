#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$DOTFILES/git/config/config" "$XDG_CONFIG_HOME/git/config"
mkdir -p $SCRIPTS_DIR
ln -sf $DOTFILES/git/config/aliases.sh $SCRIPTS_DIR/git-aliases.sh

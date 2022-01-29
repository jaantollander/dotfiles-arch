#!/bin/bash
#mkdir -p "$XDG_CONFIG_HOME/pacman"
mkdir -p $SCRIPTS_DIR
ln -sf "$DOTFILES/pacman/config/aliases.sh" "$SCRIPTS_DIR/pacman-aliases.sh"

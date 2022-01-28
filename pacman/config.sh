#!/bin/bash
#mkdir -p "$XDG_CONFIG_HOME/pacman"
mkdir -p $XDG_CONFIG_HOME/aliases
ln -sf "$DOTFILES/pacman/config/aliases.sh" "$XDG_CONFIG_HOME/aliases/pacman.sh"

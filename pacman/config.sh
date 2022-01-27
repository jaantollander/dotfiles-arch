#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/pacman"
ln -sf "$DOTFILES/pacman/config/aliases.sh" "$XDG_CONFIG_HOME/pacman/aliases.sh"

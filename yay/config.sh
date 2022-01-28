#!/bin/bash
#mkdir -p "$XDG_CONFIG_HOME/yay"
mkdir -p $XDG_CONFIG_HOME/aliases
ln -sf "$DOTFILES/yay/config/aliases.sh" "$XDG_CONFIG_HOME/aliases/yay.sh"

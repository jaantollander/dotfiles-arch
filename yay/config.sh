#!/bin/bash
#mkdir -p "$XDG_CONFIG_HOME/yay"
mkdir -p $SCRIPTS_DIR
ln -sf "$DOTFILES/yay/config/aliases.sh" "$SCRIPTS_DIR/yay-aliases.sh"

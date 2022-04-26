#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell/interactive"
ln -sf "$DOTFILES/yay/config/@interactive.sh" "$XDG_CONFIG_HOME/shell/interactive/yay.sh"

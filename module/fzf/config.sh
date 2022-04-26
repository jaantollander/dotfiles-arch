#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell/env"
mkdir -p "$XDG_CONFIG_HOME/shell/interactive"
ln -sf "$DOTFILES/fzf/config/@env.sh" "$XDG_CONFIG_HOME/shell/env/fzf.sh"
ln -sf "$DOTFILES/fzf/config/@interactive.sh" "$XDG_CONFIG_HOME/shell/interactive/fzf.sh"

#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell/env"
mkdir -p "$XDG_CONFIG_HOME/shell/interactive"
ln -sf "$DOTMODULE/fzf/config/@env.sh" "$XDG_CONFIG_HOME/shell/env/fzf.sh"

mkdir -p "$XDG_CONFIG_HOME/zsh/interactive"
ln -sf "$DOTMODULE/fzf/config/@interactive.zsh" "$XDG_CONFIG_HOME/zsh/interactive/fzf.zsh"

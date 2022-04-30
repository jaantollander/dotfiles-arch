#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell/env"
mkdir -p "$XDG_CONFIG_HOME/shell/interactive"
ln -sf "$DOTMODULE/fzf/config/@env.sh" "$XDG_CONFIG_HOME/shell/env/fzf.sh"
ln -sf "$DOTMODULE/fzf/config/@interactive.sh" "$XDG_CONFIG_HOME/shell/interactive/fzf.sh"

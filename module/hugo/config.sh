#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell/interactive"
ln -sf "$DOTMODULE/hugo/config/@interactive.sh" "$XDG_CONFIG_HOME/shell/interactive/hugo.sh"

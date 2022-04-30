#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell/interactive"
ln -sf "$DOTMODULE/dbxcli/config/@interactive.sh" "$XDG_CONFIG_HOME/shell/interactive/dbxcli.sh"

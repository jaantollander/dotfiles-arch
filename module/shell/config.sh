#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell"
mkdir -p "$XDG_CONFIG_HOME/shell/env"
mkdir -p "$XDG_CONFIG_HOME/shell/login"
mkdir -p "$XDG_CONFIG_HOME/shell/interactive"

ln -sf "$DOTMODULE/shell/config/@env.sh" "$XDG_CONFIG_HOME/shell/env.sh"
ln -sf "$DOTMODULE/shell/config/@login.sh" "$XDG_CONFIG_HOME/shell/login.sh"
ln -sf "$DOTMODULE/shell/config/@interactive.sh" "$XDG_CONFIG_HOME/shell/interactive.sh"

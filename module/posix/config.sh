#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/posix"
mkdir -p "$XDG_CONFIG_HOME/posix/env"
mkdir -p "$XDG_CONFIG_HOME/posix/login"
mkdir -p "$XDG_CONFIG_HOME/posix/interactive"

ln -sf "$DOTMODULE/posix/config/@env.sh" "$XDG_CONFIG_HOME/posix/env.sh"
ln -sf "$DOTMODULE/posix/config/@login.sh" "$XDG_CONFIG_HOME/posix/login.sh"
ln -sf "$DOTMODULE/posix/config/@interactive.sh" "$XDG_CONFIG_HOME/posix/interactive.sh"

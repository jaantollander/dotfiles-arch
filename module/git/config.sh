#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$DOTMODULE/git/config/config" "$XDG_CONFIG_HOME/git/config"

mkdir -p "$XDG_CONFIG_HOME/posix/env"
ln -sf "$DOTMODULE/git/config/@env.sh" "$XDG_CONFIG_HOME/posix/env/git.sh"

mkdir -p "$XDG_CONFIG_HOME/posix/interactive"
ln -sf "$DOTMODULE/git/config/@interactive.sh" "$XDG_CONFIG_HOME/posix/interactive/git.sh"

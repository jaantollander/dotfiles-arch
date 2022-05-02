#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/posix/interactive"
ln -sf "$DOTMODULE/yay/config/@interactive.sh" "$XDG_CONFIG_HOME/posix/interactive/yay.sh"

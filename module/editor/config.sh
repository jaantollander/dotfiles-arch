#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/posix/env"
ln -sf "$DOTMODULE/editor/config/@env.sh" "$XDG_CONFIG_HOME/posix/env/editor.sh"

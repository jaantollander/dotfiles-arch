#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/posix/env"
ln -sf "$DOTMODULE/qt/config/@env.sh" "$XDG_CONFIG_HOME/posix/env/qt.sh"

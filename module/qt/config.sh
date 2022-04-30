#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell/env"
ln -sf "$DOTMODULE/qt/config/@env.sh" "$XDG_CONFIG_HOME/shell/env/qt.sh"

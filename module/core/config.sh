#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/posix/interactive"
ln -sf "$DOTMODULE/core/config/@interactive.sh" "$XDG_CONFIG_HOME/posix/interactive/core.sh"

if [ ! -f "$DOTMODULE/core/config/lscolors.sh" ]; then
    curl "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/lscolors.sh" > "$DOTMODULE/core/config/lscolors.sh"
fi

ln -sf "$DOTMODULE/core/config/lscolors.sh" "$XDG_CONFIG_HOME/posix/interactive/lscolors.sh"

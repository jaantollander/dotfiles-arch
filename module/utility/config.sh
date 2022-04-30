#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell/interactive"
ln -sf "$DOTMODULE/utility/config/@interactive.sh" "$XDG_CONFIG_HOME/shell/interactive/utility.sh"

if [ ! -f "$DOTMODULE/utility/config/lscolors.sh" ]; then
    curl "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/lscolors.sh" > "$DOTMODULE/utility/config/lscolors.sh"
fi

ln -sf "$DOTMODULE/utility/config/lscolors.sh" "$XDG_CONFIG_HOME/shell/interactive/lscolors.sh"

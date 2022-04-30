#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/gocket"
if [ -f "$XDG_CONFIG_HOME/gocket/config.yml" ]; then
    echo "key: \"<token>\"" > "$XDG_CONFIG_HOME/gocket/config.yml"
fi

mkdir -p "$XDG_CONFIG_HOME/shell/interactive"
ln -sf "$DOTMODULE/gocket/config/@interactive.sh" "$XDG_CONFIG_HOME/shell/interactive/gocket.sh"

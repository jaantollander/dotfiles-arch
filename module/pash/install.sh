#!/usr/bin/env sh
mkdir -p "$DOTMODULE/pash/config"
mkdir -p "$XDG_BIN_HOME"
TMP=$(mktemp -d)
git clone "https://github.com/dylanaraps/pash" "$TMP"
cp "$TMP/pash" "$DOTMODULE/pash/config/pash"
rm -rf "$TMP"
cp "$DOTMODULE/pash/config/pash" "$XDG_BIN_HOME/pash"

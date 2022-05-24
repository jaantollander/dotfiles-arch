#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/posix/interactive"
ln -sf "$DOTMODULE/browser/config/@env.sh" "$XDG_CONFIG_HOME/posix/interactive/browser.sh"

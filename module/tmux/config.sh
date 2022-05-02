#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTMODULE/tmux/config/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

mkdir -p "$XDG_CONFIG_HOME/posix/interactive"
ln -sf "$DOTMODULE/tmux/config/@interactive.sh" "$XDG_CONFIG_HOME/posix/interactive/tmux.sh"

if [ ! -d "$XDG_CONFIG_HOME/tmux/plugins" ]; then
    git clone "https://github.com/tmux-plugins/tpm" "$XDG_CONFIG_HOME/tmux/plugins/tpm"
fi

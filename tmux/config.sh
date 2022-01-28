#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/config/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"
ln -sf "$DOTFILES/tmux/config/aliases.sh" "$XDG_CONFIG_HOME/tmux/aliases.sh"
ln -sf "$DOTFILES/tmux/config/scripts.sh" "$XDG_CONFIG_HOME/tmux/scripts.sh"

if [ ! -d "$XDG_CONFIG_HOME/tmux/plugins" ]; then
    git clone "https://github.com/tmux-plugins/tpm" "$XDG_CONFIG_HOME/tmux/plugins/tpm"
fi

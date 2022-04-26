#!/usr/bin/env sh
ln -sf "$DOTFILES/xdg/config/user-dirs.dirs" "$XDG_CONFIG_HOME/user-dirs.dirs"

mkdir -p "$XDG_CONFIG_HOME/shell/env"
ln -sf "$DOTFILES/xdg/config/@env.sh" "$XDG_CONFIG_HOME/shell/env/xdg.sh"

mkdir -p "$XDG_CONFIG_HOME/shell/login"
ln -sf "$DOTFILES/xdg/config/@login.sh" "$XDG_CONFIG_HOME/shell/login/xdg.sh"

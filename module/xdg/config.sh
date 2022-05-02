#!/usr/bin/env sh
ln -sf "$DOTMODULE/xdg/config/user-dirs.dirs" "$XDG_CONFIG_HOME/user-dirs.dirs"

mkdir -p "$XDG_CONFIG_HOME/posix/env"
ln -sf "$DOTMODULE/xdg/config/@env.sh" "$XDG_CONFIG_HOME/posix/env/xdg.sh"

mkdir -p "$XDG_CONFIG_HOME/posix/login"
ln -sf "$DOTMODULE/xdg/config/@login.sh" "$XDG_CONFIG_HOME/posix/login/xdg.sh"

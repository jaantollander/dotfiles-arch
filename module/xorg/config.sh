#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/X11"
ln -sf "$DOTMODULE/xorg/config/xinitrc.sh" "$XDG_CONFIG_HOME/X11/xinitrc.sh"

mkdir -p "$XDG_CONFIG_HOME/X11/xinitrc"
ln -sf "$DOTMODULE/xorg/config/style.xresources" "$XDG_CONFIG_HOME/X11/xinitrc/style.xresources"

mkdir -p "$XDG_CONFIG_HOME/posix/login"
ln -sf "$DOTMODULE/xorg/config/@login.sh" "$XDG_CONFIG_HOME/posix/login/xorg.sh"

mkdir -p "$XDG_CONFIG_HOME/posix/interactive"
ln -sf "$DOTMODULE/xorg/config/@interactive.sh" "$XDG_CONFIG_HOME/posix/interactive/xorg.sh"

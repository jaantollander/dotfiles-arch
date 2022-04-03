#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/X11
ln -sf $DOTFILES/xorg/config/xinitrc.sh $XDG_CONFIG_HOME/X11/xinitrc.sh

mkdir -p $XDG_CONFIG_HOME/X11/xinitrc
ln -sf $DOTFILES/xorg/config/style.xresources $XDG_CONFIG_HOME/X11/xinitrc/style.xresources

mkdir -p $XDG_CONFIG_HOME/shell/login
ln -sf $DOTFILES/xorg/config/@login.sh $XDG_CONFIG_HOME/shell/login/xorg.sh

mkdir -p $XDG_CONFIG_HOME/shell/interactive
ln -sf $DOTFILES/xorg/config/@interactive.sh $XDG_CONFIG_HOME/shell/interactive/xorg.sh

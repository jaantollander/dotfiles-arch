#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/X11/xinitrc
ln -sf $DOTFILES/urxvt/config/urxvt.xresources $XDG_CONFIG_HOME/X11/xinitrc/urxvt.xresources
ln -sf $DOTFILES/urxvt/config/xinitrc.sh $XDG_CONFIG_HOME/X11/xinitrc/urxvt.sh

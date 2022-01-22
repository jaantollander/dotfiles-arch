#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/brightnessctl
ln -sf $DOTFILES/brightnessctl/config/i3.conf $XDG_CONFIG_HOME/brightnessctl/i3.conf

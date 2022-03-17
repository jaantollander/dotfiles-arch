#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/lsd
ln -sf $DOTFILES/lsd/config/config.yaml $XDG_CONFIG_HOME/lsd/config.yaml

mkdir -p $XDG_CONFIG_HOME/shell/interactive
ln -sf $DOTFILES/lsd/config/interactive.sh $XDG_CONFIG_HOME/shell/interactive/lsd.sh

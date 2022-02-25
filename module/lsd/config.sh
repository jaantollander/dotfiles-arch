#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/lsd
ln -sf $DOTFILES/lsd/config/config.yaml $XDG_CONFIG_HOME/lsd/config.yaml

ln -sf $DOTFILES/lsd/config/aliases.sh $XDG_SCRIPTS_HOME/lsd-aliases.sh

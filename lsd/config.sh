#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/lsd
ln -sf $DOTFILES/lsd/config/config.yaml $XDG_CONFIG_HOME/lsd/config.yaml

mkdir -p $SCRIPTS_DIR
ln -sf $DOTFILES/lsd/config/aliases.sh $SCRIPTS_DIR/lsd-aliases.sh

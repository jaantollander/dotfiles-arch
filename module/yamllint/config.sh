#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/yamllint
ln -sf $DOTFILES/yamllint/config/config.yaml $XDG_CONFIG_HOME/yamllint/config

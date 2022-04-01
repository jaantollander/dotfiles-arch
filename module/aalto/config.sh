#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/shell/interactive
ln -sf $DOTFILES/aalto/config/@interactive.sh $XDG_CONFIG_HOME/shell/interactive/aalto.sh

mkdir -p $HOME/.ssh/config.d
ln -sf $DOTFILES/aalto/config/ssh $HOME/.ssh/config.d/aalto

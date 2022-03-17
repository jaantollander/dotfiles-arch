#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/shell/interactive
ln -sf $DOTFILES/fzf/config/interactive.sh $XDG_CONFIG_HOME/shell/interactive/fzf.sh

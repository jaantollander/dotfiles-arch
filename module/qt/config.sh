#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/shell/environment
ln -sf $DOTFILES/qt/config/environment.sh $XDG_CONFIG_HOME/shell/environment/qt.sh

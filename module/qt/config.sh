#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/shell/env
ln -sf $DOTFILES/qt/config/@env.sh $XDG_CONFIG_HOME/shell/env/qt.sh

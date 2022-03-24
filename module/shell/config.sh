#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/shell
mkdir -p $XDG_CONFIG_HOME/shell/env
mkdir -p $XDG_CONFIG_HOME/shell/login
mkdir -p $XDG_CONFIG_HOME/shell/interactive

ln -sf $DOTFILES/shell/config/@env.sh $XDG_CONFIG_HOME/shell/env.sh
ln -sf $DOTFILES/shell/config/@login.sh $XDG_CONFIG_HOME/shell/login.sh
ln -sf $DOTFILES/shell/config/@interactive.sh $XDG_CONFIG_HOME/shell/interactive.sh

if [[ ! -f $DOTFILES/shell/config/lscolors.sh ]]; then
    curl https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/lscolors.sh > $DOTFILES/shell/config/lscolors.sh
fi

ln -sf $DOTFILES/shell/config/lscolors.sh $XDG_CONFIG_HOME/shell/interactive/lscolors.sh

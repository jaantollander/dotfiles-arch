#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/shell/interactive
ln -sf $DOTFILES/utility/config/@interactive.sh $XDG_CONFIG_HOME/shell/interactive/utility.sh

if [[ ! -f $DOTFILES/utility/config/lscolors.sh ]]; then
    curl https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/lscolors.sh > $DOTFILES/shell/config/lscolors.sh
fi

ln -sf $DOTFILES/utility/config/lscolors.sh $XDG_CONFIG_HOME/shell/interactive/lscolors.sh

#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/shell
mkdir -p $XDG_CONFIG_HOME/shell/env
mkdir -p $XDG_CONFIG_HOME/shell/interactive

ln -sf $DOTFILES/shell/config/env.sh $XDG_CONFIG_HOME/shell/env.sh
ln -sf $DOTFILES/shell/config/login.sh $XDG_CONFIG_HOME/shell/login.sh
ln -sf $DOTFILES/shell/config/interactive.sh $XDG_CONFIG_HOME/shell/interactive.sh
ln -sf $DOTFILES/shell/config/dircolors $XDG_CONFIG_HOME/shell/dircolors

#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/shell
mkdir -p $XDG_CONFIG_HOME/shell/environment
mkdir -p $XDG_CONFIG_HOME/shell/interactive

ln -sf $DOTFILES/shell/config/environment.sh $XDG_CONFIG_HOME/shell/environment.sh
ln -sf $DOTFILES/shell/config/profile.sh $XDG_CONFIG_HOME/shell/profile.sh
ln -sf $DOTFILES/shell/config/interactive.sh $XDG_CONFIG_HOME/shell/interactive.sh
ln -sf $DOTFILES/shell/config/dircolors $XDG_CONFIG_HOME/shell/dircolors

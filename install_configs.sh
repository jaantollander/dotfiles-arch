#!/bin/bash

# Include common environment variables
export DOTFILES=$HOME/dotfiles

# For configuration files 
export XDG_CONFIG_HOME="$HOME/.config"

# For user specific data
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"

# For user cached files
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# Directory for custom scripts
export SCRIPTS_DIR="$XDG_CONFIG_HOME/scripts"

config() {
    for c in $@; do
        source "$DOTFILES/$c/config.sh"
    done
}

config pacman \
       yay \
       bash \
       xdg \
       fonts \
       X11 \
       urxvt \
       xrandr \
       i3 \
       rofi \
       dunst \
       udiskie \
       pulse \
       brightnessctl \
       bluez \
       maim \
       fzf \
       lsd \
       zsh \
       git \
       gh \
       nvim \
       tmux \
       redshift \
       zathura

#config julia

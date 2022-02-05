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
    source "$DOTFILES/$1/config.sh"
}

config bash
config pacman
config fonts
config urxvt
config X11
config xrandr
config i3
config rofi
config dunst
config udiskie
config pulse
config brightnessctl
config bluez
config maim
config fzf
config lsd
config zsh
config git
config gh
config nvim
config tmux
config redshift
config zathura
#config julia

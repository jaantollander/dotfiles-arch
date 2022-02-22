#!/bin/bash

# Include common environment variables
export DOTFILES=$HOME/dotfiles

# Define and create base directories
source $DOTFILES/xdg/config/base-dirs-env.sh
source $DOTFILES/xdg/config/base-dirs-mk.sh

# Define and create user directories
source $DOTFILES/xdg/config/user-dirs-env.sh
source $DOTFILES/xdg/config/user-dirs-mk.sh

config() {
    for c in $@; do
        echo "Installing configs for $c"
        source "$DOTFILES/$c/config.sh"
    done
}

config `cat $DOTFILES/install/dependencies`

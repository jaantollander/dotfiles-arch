#!/bin/bash

TARGET=$1


# Include common environment variables
export DOTFILES=$HOME/dotfiles


# Define and create base directories
source $DOTFILES/xdg/config/base-dirs-env.sh
source $DOTFILES/xdg/config/base-dirs-mk.sh

# Define and create user directories
source $DOTFILES/xdg/config/user-dirs-env.sh
source $DOTFILES/xdg/config/user-dirs-mk.sh


# Config target and its dependencies
config() {
    if [[ -f $DOTFILES/$1/config.sh ]]; then
        echo "Configuring \"$1\""
        source $DOTFILES/$1/config.sh
    fi
}

config $TARGET

for DEP in `cat $DOTFILES/$TARGET/dependencies`; do
    config $DEP
done

#!/usr/bin/env bash

export DOTFILES="$HOME/dotfiles"


yay() {
    source $DOTFILES/yay/install.sh
}


_add_packages() {
    TMP=$1
    MODULE=$2
    PKGS=$DOTFILES/$MODULE/packages
    if [[ -f $PKGS/official ]]; then
        cat $PKGS/official >> $TMP/official
    fi
    if [[ -f $PKGS/aur ]]; then
        cat $PKGS/aur >> $TMP/aur
    fi
}

packages() {
    # Arguments
    MODULES=$*

    # If "yay" is not installed exit with error.
    if [[ ! $(command -v "yay") ]]; then
        echo "Install Yay before installing packages."
        echo "bash \$DOTFILES/yay/install.sh"
        exit 1
    fi

    # Sync, Refresh and Upgrade
    sudo pacman --sync --refresh --sysupgrade --color=auto

    # Collect and install packages from official repositories and AUR
    TMP=`mktemp -d`
    echo "" > $TMP/official
    echo "" > $TMP/aur

    for MODULE in $MODULES; do
        _add_packages $TMP $MODULE
        DEPS=$DOTFILES/$MODULE/dependencies
        if [[ -f $DEPS ]]; then
            for DEP in `cat $DEPS`; do
                _add_packages $TMP $DEP
            done
        fi
    done

    sudo pacman --sync --needed --color=auto `cat $TMP/official | sort | uniq`
    yay --sync --needed --color=auto `cat $TMP/aur | sort | uniq`
}


_config() {
    MODULE=$1
    if [[ -f $DOTFILES/$MODULE/config.sh ]]; then
        echo "Configuring \"$MODULE\""
        source $DOTFILES/$MODULE/config.sh
    fi
}

config() {
    # Arguments
    MODULES=$*

    # Define and create base directories
    source $DOTFILES/xdg/config/base-dirs-env.sh
    source $DOTFILES/xdg/config/base-dirs-mk.sh
    
    # Define and create user directories
    source $DOTFILES/xdg/config/user-dirs-env.sh
    source $DOTFILES/xdg/config/user-dirs-mk.sh

    # Config modules
    for MODULE in $MODULES; do
        _config $MODULE
        DEPS=$DOTFILES/$MODULE/dependencies
        if [[ -f $DEPS ]]; then
            for DEP in `cat $DEPS`; do
                _config $DEP
            done
        fi
    done
}


# Expose functions as arguments.
# Usage:
# `install.sh <operation> <args>`
# Examples:
# `install.sh yay`
# `install.sh packages <module1> <module2> <...>`
# `install.sh config <module1> <module2> <...>`
$*

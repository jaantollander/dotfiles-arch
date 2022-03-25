#!/usr/bin/env bash

export DOTFILES="$HOME/dotfiles/module"


install() {
    MODULE=$1
    source $DOTFILES/$1/install.sh
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

    # Define and create base and user directories
    source $DOTFILES/xdg/config/@env.sh
    source $DOTFILES/xdg/config/@login.sh
    
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


# Help message
function help() {
    echo "Manage the Arch Linux configuration."
    echo ""
    echo "Usage:"
    echo "- ./dotfiles.sh <operation> <args>"
    echo ""
    echo "Examples:"
    echo "- Print help message."
    echo "  ./dotfiles.sh"
    echo "  ./dotfiles.sh help"
    echo ""
    echo "- Run install script for a module."
    echo "  ./dotfiles.sh install <module>"
    echo ""
    echo "- Install packages for one or more modules."
    echo "  ./dotfiles.sh packages <module1> <module2> <...>"
    echo ""
    echo "- Install configurations for one or more modules."
    echo "  ./dotfiles.sh config <module1> <module2> <...>"
}


# Print help message on:
# `./dotfiles.sh`
# `./dotfiles.sh help`
if [[ -z $* ]]; then
    help
fi


# Expose functions as arguments.
$*

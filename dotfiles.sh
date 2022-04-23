#!/usr/bin/env bash

export DOTFILES="$HOME/dotfiles/module"


install() {
    MODULE="$1"
    source "$DOTFILES/$1/install.sh"
}

packages() {
    # Arguments
    MODULES=$*

    # Collect all modules and their dependecies
    declare -A ALL_MODULES
    for MODULE in $MODULES; do
        if [[ -z ${ALL_MODULES[$MODULE]} ]]; then
            echo "module: $MODULE"
            ALL_MODULES[$MODULE]="1"
            DEPS="$DOTFILES/$MODULE/dependencies"
            if [[ -f "$DEPS" ]]; then
                while read -r MODULE_DEP; do
                    if [[ -z ${ALL_MODULES[$MODULE_DEP]} ]]; then
                        echo "module: $MODULE_DEP"
                        ALL_MODULES[$MODULE_DEP]="1"
                    fi
                done < "$DEPS"
            fi
        fi
    done

    # Collect and install packages from official repositories and AUR
    OFFICIAL=()
    AUR=()

    for MODULE in "${!ALL_MODULES[@]}"; do
        FILE="$DOTFILES/$MODULE/packages/official"
        [ -r "$FILE" ] && OFFICIAL+=("$FILE")
        FILE="$DOTFILES/$MODULE/packages/aur"
        [ -r "$FILE" ] && AUR+=("$FILE")
    done

    # If "yay" is not installed exit with error.
    if [ ! "$(command -v "yay")" ]; then
        echo "Install Yay before installing packages."
        exit 1
    fi

    # Sync, Refresh and Upgrade
    sudo pacman --sync --refresh --sysupgrade --color=auto

    # shellcheck disable=2068
    if [[ -n "${OFFICIAL[*]}" ]]; then
        cat ${OFFICIAL[@]} \
            | sort \
            | uniq \
            | sudo pacman --sync --needed --color=auto -
    fi

    # shellcheck disable=2068
    if [[ -n "${AUR[*]}" ]]; then
        cat ${AUR[@]} \
            | sort \
            | uniq \
            | yay --sync --needed --color=auto -
    fi
}

config() {
    # Arguments
    MODULES=$*

    # Collect all modules and their dependecies
    declare -A ALL_MODULES
    for MODULE in $MODULES; do
        if [[ -z ${ALL_MODULES[$MODULE]} ]]; then
            echo "module: $MODULE"
            ALL_MODULES[$MODULE]="1"
            DEPS="$DOTFILES/$MODULE/dependencies"
            if [[ -f "$DEPS" ]]; then
                while read -r MODULE_DEP; do
                    if [[ -z ${ALL_MODULES[$MODULE_DEP]} ]]; then
                        echo "module: $MODULE_DEP"
                        ALL_MODULES[$MODULE_DEP]="1"
                    fi
                done < "$DEPS"
            fi
        fi
    done

    # Define and create base and user directories
    source "$DOTFILES/xdg/config/@env.sh"
    source "$DOTFILES/xdg/config/@login.sh"

    # Config modules
    for MODULE in "${!ALL_MODULES[@]}"; do
        if [[ -r $DOTFILES/$MODULE/config.sh ]]; then
            echo "config: $MODULE"
            source "$DOTFILES/$MODULE/config.sh"
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
if [ -z "$*" ]; then
    help
fi


# Expose functions as arguments.
$*

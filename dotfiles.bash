#!/usr/bin/env bash

# Paths
export DOTFILES="$HOME/dotfiles"
export DOTMODULE="$DOTFILES/module"

# File names
DEPENDENCIES="dependencies"
CONFIG="config.sh"
PACKAGES_OFFICIAL="packages/official"
PACKAGES_AUR="packages/aur"

# Define and create base and user directories
source "$DOTMODULE/xdg/config/@env.sh"
source "$DOTMODULE/xdg/config/@login.sh"


install() {
    local MODULE=$1
    "$DOTMODULE/$MODULE/install.sh"
}

__dependencies() {
    for MODULE in "$@"; do
        if [[ -z ${ALL_MODULES[$MODULE]} ]]; then
            ALL_MODULES[$MODULE]="1"
            DEPS="$DOTMODULE/$MODULE/$DEPENDENCIES"
            if [[ -f "$DEPS" ]]; then
                __dependencies "$(tr '\n' ' ' < "$DEPS")"
            fi
        fi
    done
}

dependencies() {
    local MODULES ALL_MODULES
    MODULES=$*
    declare -A ALL_MODULES
    __dependencies "$MODULES"
    echo "${!ALL_MODULES[@]}"
}

packages() {
    # Collect and install packages from official repositories and AUR
    local MODULES OFFICIAL AUR FILE
    MODULES=$*
    declare -a OFFICIAL
    declare -a AUR

    for MODULE in $(dependencies "$MODULES"); do
        FILE="$DOTMODULE/$MODULE/$PACKAGES_OFFICIAL"
        [[ -r "$FILE" ]] && OFFICIAL+=("$FILE")
        FILE="$DOTMODULE/$MODULE/$PACKAGES_AUR"
        [[ -r "$FILE" ]] && AUR+=("$FILE")
    done

    # If "yay" is not installed exit with error.
    if [[ -z "$(command -v "yay")" ]]; then
        echo "Install Yay before installing packages."
        exit 1
    fi

    # Sync, Refresh and Upgrade
    sudo pacman --sync --refresh --sysupgrade --color=auto

    if [[ "${#OFFICIAL[@]}" -ge 0 ]]; then
        cat "${OFFICIAL[@]}" \
            | sort \
            | uniq \
            | sudo pacman --sync --needed --color=auto -
    fi

    if [[ "${#AUR[@]}" -ge 0 ]]; then
        cat "${AUR[@]}" \
            | sort \
            | uniq \
            | yay --sync --needed --color=auto -
    fi
}

config() {
    local MODULES=$*
    for MODULE in $(dependencies "$MODULES"); do
        if [[ -x "$DOTMODULE/$MODULE/$CONFIG" ]]; then
            echo "config: $MODULE"
            "$DOTMODULE/$MODULE/$CONFIG"
        fi
    done
}

function help() {
    echo "Manage the Arch Linux configuration."
    echo ""
    echo "USAGE"
    echo "- General usage."
    echo "  ./dotfiles.bash <operation> <args>"
    echo ""
    echo "- Print help message."
    echo "  ./dotfiles.bash help"
    echo ""
    echo "- Run install script for a module."
    echo "  ./dotfiles.bash install <module>"
    echo ""
    echo "- Install packages for one or more modules."
    echo "  ./dotfiles.bash packages <module1> <module2> <...>"
    echo ""
    echo "- Install configurations for one or more modules."
    echo "  ./dotfiles.bash config <module1> <module2> <...>"
}

# Print help message on:
# `./dotfiles.bash`
# `./dotfiles.bash help`
if [[ -z "$*" ]]; then
    help
fi

# Expose functions as arguments.
"$@"

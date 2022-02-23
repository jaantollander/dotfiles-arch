#!/bin/bash

TARGET=$1


# If "yay" is not installed exit with error.
if [[ ! $(command -v "yay") ]]; then
    echo "Install Yay before trying to install packages."
    exit 1
fi

export DOTFILES=$HOME/dotfiles


# Sync, Refresh and Upgrade
sudo pacman --sync --refresh --sysupgrade 


# Install packages from official repositories and AUR
packages() {
    PKGS=$DOTFILES/$1/packages
    if [[ -f $PKGS/official ]]; then
        echo "Installing official packages for \"$1\""
        sudo pacman --sync `cat $PKGS/official`
    fi
    if [[ -f $PKGS/aur ]]; then
        echo "Installing AUR packages for \"$1\""
        yay --sync `cat $PKGS/aur`
    fi
}

packages $TARGET
 
for DEP in $DOTFILES/$TARGET/dependencies; do
    packages $DEP
done

#!/bin/bash

# If "yay" is not installed exit with error.
if [[ ! $(command -v "yay") ]]; then
    echo "Install Yay before trying to install packages."
    exit 1
fi

export DOTFILES=$HOME/dotfiles

packages() {
    source $DOTFILES/$1/packages.sh
}

sudo pacman --sync --refresh --sysupgrade 
sudo pacman -S `cat $DOTFILES/install/packages/official`
packages `cat $DOTFILES/install/dependencies`
yay -S `cat $DOTFILES/install/packages/aur`

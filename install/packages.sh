#!/bin/bash

# If "yay" is not installed exit with error.
if [[ ! $(command -v "yay") ]]; then
    echo "Install Yay before trying to install packages."
    exit 1
fi

export DOTFILES=$HOME/dotfiles

sudo pacman --sync --refresh --sysupgrade 

# Install packages from official repositories
sudo pacman -S `cat $DOTFILES/install/packages/official`
for DEP in $DOTFILES/install/dependencies; do
    sudo pacman -S `cat $DOTFILES/$DEP/packages/official`
done

# Install packages from AUR
yay -S `cat $DOTFILES/install/packages/aur`
for DEP in $DOTFILES/install/dependencies; do
    sudo pacman -S `cat $DOTFILES/$DEP/packages/aur`
done

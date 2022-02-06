#!/bin/bash

export DOTFILES=$HOME/dotfiles

packages() {
    source $DOTFILES/$1/packages.sh
}

sudo pacman --sync --refresh --sysupgrade 

# Creating Documents
sudo pacman -S pandoc
# TODO: confirm "all" automatically
sudo pacman -S texlive-most
sudo pacman -S k2pdfopt

# Programming and Development
packages julia
sudo pacman -S nodejs #yarn
sudo pacman -S podman
yay -S netlify
sudo pacman -S hugo

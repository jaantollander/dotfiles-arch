#!/bin/bash

export DOTFILES=$HOME/dotfiles

packages() {
    source $DOTFILES/$1/packages.sh
}

sudo pacman --sync --refresh --sysupgrade 

# PDF Tools
sudo pacman -S k2pdfopt ghostscript

# Creating Documents
sudo pacman -S texlive-most pandoc hugo

# Programming and Development
sudo pacman -S python
packages julia
sudo pacman -S nodejs yarn
# go
# rust
# haskell

# Cloud
yay -S netlify
# podman
# openstack
# openshift
# kubernetes

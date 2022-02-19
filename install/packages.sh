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

# Manuals
sudo pacman -S man man-pages 
sudo pacman -S tldr

# Packaging
sudo pacman -S pkgstats

# Networking
sudo pacman -S networkmanager openssh openvpn

# Version Control
packages git

# Desktop, Terminal and Shell
packages urxvt
packages X11
packages udiskie
packages xrandr
packages i3
packages i3status
packages pulse
packages brightnessctl
packages rofi
packages dunst
packages redshift
packages tmux
packages ripgrep
packages fzf
packages zsh
packages lsd
packages bat
packages bluez
packages maim

# Text Editors and Manipulation
packages nvim
sudo pacman -S dos2unix

# Process Information
sudo pacman -S htop

# System Information
sudo pacman -S neofetch

# File Synchronization
sudo pacman -S rsync 

# File Archiving
sudo pacman -S unzip

# Display Images
sudo pacman -S feh

# Document Viewer
packages zathura
sudo pacman -S mupdf

# Browsers
sudo pacman -S firefox 
yay -S brave-bin
#yay -S browsh

# Password Manager
sudo pacman -S keepassxc

# Accounting
sudo pacman -S hledger hledger-ui

# Communication
sudo pacman -S telegram-desktop

# File Sharing 
sudo pacman -S qbittorrent

# Screencast
yay -S screencast

# PDF Tools
sudo pacman -S ghostscript poppler
yay -S k2pdfopt

# Creating Documents
sudo pacman -S texlive-most
sudo pacman -S pandoc

# GitHub Client
packages gh

# Programming and Development
sudo pacman -S python
sudo pacman -S nodejs yarn
packages julia
# go
# rust
# haskell

# Cloud
yay -S netlify
# podman
# kubernetes
# openstack
# openshift

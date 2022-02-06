#!/bin/bash

export DOTFILES=$HOME/dotfiles

packages() {
    source $DOTFILES/$1/packages.sh
}

sudo pacman --sync --refresh --sysupgrade 

# Manuals
sudo pacman -S man man-pages 
sudo pacman -S tldr

# Networking
sudo pacman -S networkmanager openssh openvpn

# If "yay" is not installed, install it.
# Yay is an helper for installing packages from Arch User Repository (AUR).
#if [[ ! $(command -v "yay") ]]; then
#    bash $DOTFILES/yay/install.sh
#fi

# Desktop, Terminal and Shell
packages urxvt
packages X11
packages udiskie
packages xrandr
packages i3
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
packages bluez
packages maim

# Text Editors and Manipulation
packages nvim
sudo pacman -S dos2unix

# Version Control
packages git
packages gh

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

# Browsers
sudo pacman -S firefox 
yay -S brave-bin

# Password Manager
sudo pacman -S keepassxc

# Accounting
sudo pacman -S hledger hledger-ui

# Communication
sudo pacman -S telegram-desktop

# File Sharing 
sudo pacman -S qbittorrent

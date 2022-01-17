#!/bin/bash
sudo pacman --sync --refresh --sysupgrade 

# Manuals
sudo pacman -S man man-pages tldr

# Networking
sudo pacman -S networkmanager openssh openvpn

# File Synchronization
sudo pacman -S rsync 

# Command-line Utilities 
sudo pacman -S tree 

# Arch User Repository (AUR)
source $DOTFILES/yay/packages.sh

# Desktop, Terminal and Shell
source $DOTFILES/X11/packages.sh
source $DOTFILES/i3/packages.sh
source $DOTFILES/rofi/packages.sh
source $DOTFILES/dunst/packages.sh
source $DOTFILES/redshift/packages.sh
source $DOTFILES/tmux/packages.sh
source $DOTFILES/zsh/packages.sh
sudo pacman -S scrot htop 

# Text Editors and Manipulation
source $DOTFILES/nvim/packages.sh
sudo pacman -S dos2unix

# Version Control
source $DOTFILES/git/packages.sh
source $DOTFILES/gh/packages.sh

# Browsers
sudo pacman -S firefox 
sudo pacman -S brave-bin

# Password Manager
sudo pacman -S keepassxc

# Accounting
sudo pacman -S hledger hledger-ui

# File Sharing 
# source $DOTFILES/rtorrent/packages.sh
sudo pacman -S qbittorrent

# Programming
source $DOTFILES/julia/packages.sh
#pacman -S nodejs yarn

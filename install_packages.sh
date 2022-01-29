#!/bin/bash
sudo pacman --sync --refresh --sysupgrade 

# Manuals
sudo pacman -S man man-pages 
sudo pacman -S tldr
sudo pacman -S arch-wiki-docs arch-wiki-lite

# Networking
sudo pacman -S networkmanager openssh openvpn

# File Synchronization
sudo pacman -S rsync 

# File Archiving
sudo pacman -S unzip

# Command-line Utilities 
sudo pacman -S tree 

# Display Images
sudo pacman -S feh

# Arch User Repository (AUR)
source $DOTFILES/yay/packages.sh

# Desktop, Terminal and Shell
source $DOTFILES/urxvt/packages.sh
source $DOTFILES/X11/packages.sh
source $DOTFILES/udiskie/packages.sh
source $DOTFILES/xrandr/packages.sh
source $DOTFILES/i3/packages.sh
source $DOTFILES/pulse/packages.sh
source $DOTFILES/brightnessctl/packages.sh
source $DOTFILES/rofi/packages.sh
source $DOTFILES/dunst/packages.sh
source $DOTFILES/redshift/packages.sh
source $DOTFILES/tmux/packages.sh
source $DOTFILES/zsh/packages.sh
sudo pacman -S htop neofetch

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

# Communication
sudo pacman -S telegram-desktop

# File Sharing 
# source $DOTFILES/rtorrent/packages.sh
sudo pacman -S qbittorrent

# Documents
source $DOTFILES/zathura/packages.sh
sudo pacman -S pandoc
# TODO: confirm "all" automatically
sudo pacman -S texlive-most
sudo pacman -S k2pdfopt

# Programming and Development
source $DOTFILES/julia/packages.sh
sudo pacman -S nodejs #yarn
sudo pacman -S podman
yay -S netlify
sudo pacman -S hugo

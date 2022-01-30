#!/bin/bash
packages() {
    source $DOTFILES/$1/packages.sh
}

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

# Display Images
sudo pacman -S feh

# Arch User Repository (AUR)
packages yay

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
packages fzf
packages zsh
packages lsd
sudo pacman -S htop neofetch

# Text Editors and Manipulation
packages nvim
sudo pacman -S dos2unix

# Version Control
packages git
packages gh

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
sudo pacman -S qbittorrent

# Documents
packages zathura
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

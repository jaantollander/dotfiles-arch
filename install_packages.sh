#!/bin/bash
sudo pacman --sync --refresh --sysupgrade 

sudo pacman -S man man-pages tldr
sudo pacman -S networkmanager openssh openvpn
sudo pacman -S rsync scrot htop tree

source $DOTFILES/yay/packages.sh
source $DOTFILES/X11/packages.sh
source $DOTFILES/i3/packages.sh
source $DOTFILES/rofi/packages.sh
source $DOTFILES/redshift/packages.sh
source $DOTFILES/dunst/packages.sh
source $DOTFILES/zsh/packages.sh
source $DOTFILES/tmux/packages.sh
source $DOTFILES/nvim/packages.sh
source $DOTFILES/git/packages.sh
source $DOTFILES/gh/packages.sh

sudo pacman -S firefox brave-bin
sudo pacman -S keepassxc
sudo pacman -S hledger hledger-ui

source $DOTFILES/julia/packages.sh
#pacman -S nodejs yarn

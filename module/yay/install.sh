#!/bin/bash
cd `mktemp -d`
git clone https://aur.archlinux.org/yay.git .
makepkg -s
sudo pacman -U "yay-*.pkg.tar.zst"
cd -

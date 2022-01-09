#!/bin/bash
curl -O "https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz" -o /tmp
tar -xvf "/tmp/yay.tar.gz" --directory="/tmp/"
cd "/tmp/yay/"
makepkg -s
sudo pacman -U "yay-*.pkg.tar.zst"
cd -

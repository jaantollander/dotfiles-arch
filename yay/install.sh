#!/bin/bash
OUTDIR=$(mktemp -d)
git clone https://aur.archlinux.org/yay.git $OUTDIR
cd $OUTDIR
makepkg -s
sudo pacman -U "yay-*.pkg.tar.zst"

#!/bin/bash
# Download Inconsolata Nerd Fonts from:
# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Inconsolata/complete

# Downloads font if they don't exist
mkdir -p $DOTFILES/fonts/data

BASE_URL=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/

FONTS=(
    "Inconsolata Bold Nerd Font Complete.otf"
    "Inconsolata Nerd Font Complete Mono.otf"
    "Inconsolata Nerd Font Complete.otf"
    "Inconsolata Regular Nerd Font Complete Mono.otf"
    "Inconsolata Regular Nerd Font Complete.otf"
)

for FONT in $FONTS; do
    PATH=$DOTFILES/fonts/data/$FONT
    if [[ -f $PATH ]]; then
        curl "$BASE_URL/$FONT" --output=$PATH
    fi
done

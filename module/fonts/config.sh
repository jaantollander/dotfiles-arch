#!/bin/bash

download_fonts() {
    # Download Inconsolata Nerd Fonts.
    # https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Inconsolata/complete
    BASE_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/"
    
    FONTS=(
        "Inconsolata Bold Nerd Font Complete.otf"
        "Inconsolata Nerd Font Complete Mono.otf"
        "Inconsolata Nerd Font Complete.otf"
        "Inconsolata Regular Nerd Font Complete Mono.otf"
        "Inconsolata Regular Nerd Font Complete.otf"
    )
    
    # Download fonts if they don't exist
    mkdir -p $DOTFILES/fonts/data
    
    for FONT in $FONTS; do
        FPATH=$DOTFILES/fonts/data/$FONT
        if [[ -f $FPATH ]]; then
            curl "$BASE_URL/$FONT" --output=$PATH
        fi
    done
}

download_fonts
mkdir -p "$XDG_DATA_HOME/fonts"
cp -rf $DOTFILES/fonts/data/* "$XDG_DATA_HOME/fonts"

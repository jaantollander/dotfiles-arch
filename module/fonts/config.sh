#!/bin/bash
mkdir -p "$XDG_DATA_HOME/fonts"
cp -rf $DOTFILES/fonts/data/* "$XDG_DATA_HOME/fonts"

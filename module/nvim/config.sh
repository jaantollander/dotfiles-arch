#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/nvim/undo"

ln -sf "$DOTFILES/nvim/config/init.vim" "$XDG_CONFIG_HOME/nvim"

# install neovim plugin manager
if [ ! -f "$DOTFILES/nvim/config/autoload/plug.vim" ]; then
    curl -fLo --create-dirs \
       "$DOTFILES/nvim/config/autoload/plug.vim" \
       "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi

mkdir -p "$XDG_CONFIG_HOME/nvim/autoload"
ln -sf "$DOTFILES/nvim/config/autoload/plug.vim" "$XDG_CONFIG_HOME/nvim/autoload/plug.vim"

# Install (or update) all the plugins
nvim --noplugin +PlugUpdate +qa

mkdir -p "$XDG_CONFIG_HOME/shell/env"
ln -sf "$DOTFILES/nvim/config/@env.sh" "$XDG_CONFIG_HOME/shell/env/nvim.sh"

#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/nvim/undo"

ln -sf "$DOTMODULE/nvim/config/init.vim" "$XDG_CONFIG_HOME/nvim"

# install neovim plugin manager
if test ! -f "$DOTMODULE/nvim/config/autoload/plug.vim"; then
    curl -fLo --create-dirs \
       "$DOTMODULE/nvim/config/autoload/plug.vim" \
       "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi

mkdir -p "$XDG_CONFIG_HOME/nvim/autoload"
ln -sf "$DOTMODULE/nvim/config/autoload/plug.vim" "$XDG_CONFIG_HOME/nvim/autoload/plug.vim"

# Install (or update) all the plugins
nvim --noplugin +PlugUpdate +qa

mkdir -p "$XDG_CONFIG_HOME/shell/env"
ln -sf "$DOTMODULE/nvim/config/@env.sh" "$XDG_CONFIG_HOME/shell/env/nvim.sh"

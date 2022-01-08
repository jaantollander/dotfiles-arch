#!/bin/bash

## X11
mkdir -p "$XDG_CONFIG_HOME/X11"
ln -sf "$DOTFILES/X11/xinitrc" "$XDG_CONFIG_HOME/X11/.xinitrc"
ln -sf "$DOTFILES/X11/Xresources" "$XDG_CONFIG_HOME/X11/.Xresources"
ln -sf "$DOTFILES/X11/monitor_external.sh" "$XDG_CONFIG_HOME/X11/monitor_external.sh"
ln -sf "$DOTFILES/X11/monitor_laptop.sh" "$XDG_CONFIG_HOME/X11/monitor_laptop.sh"

## i3
mkdir -p "$XDG_CONFIG_HOME/i3"
ln -sf "$DOTFILES/i3/config" "$XDG_CONFIG_HOME/i3/config"
ln -sf "$DOTFILES/i3/i3status.conf" "$XDG_CONFIG_HOME/i3/i3status.conf"

## Zsh
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/aliases" "$XDG_CONFIG_HOME/zsh/aliases"
rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/external" "$XDG_CONFIG_HOME/zsh"

## Fonts
mkdir -p "$XDG_DATA_HOME"
cp -rf "$DOTFILES/fonts" "$XDG_DATA_HOME"

## dunst
mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"

## Git
mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$DOTFILES/git/config" "$XDG_CONFIG_HOME/git/config"

## nvim
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/nvim/undo"

ln -sf "$DOTFILES/nvim/init.vim" "$XDG_CONFIG_HOME/nvim"

# install neovim plugin manager
[ ! -f "$DOTFILES/nvim/autoload/plug.vim" ] \
    && curl -fLo "$DOTFILES/nvim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p "$XDG_CONFIG_HOME/nvim/autoload"
ln -sf "$DOTFILES/nvim/autoload/plug.vim" "$XDG_CONFIG_HOME/nvim/autoload/plug.vim"

# Install (or update) all the plugins
nvim --noplugin +PlugUpdate +qa

## tmux
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

[ ! -d "$XDG_CONFIG_HOME/tmux/plugins" ] \
&& git clone https://github.com/tmux-plugins/tpm \
"$XDG_CONFIG_HOME/tmux/plugins/tpm"

## GitHub CLI
mkdir -p "$XDG_CONFIG_HOME/gh"
ln -sf "$DOTFILES/gh/config.yml" "$XDG_CONFIG_HOME/gh/config.yml"

## redshift
mkdir -p "$XDG_CONFIG_HOME/redshift"
ln -sf "$DOTFILES/redshift/redshift.conf" "$XDG_CONFIG_HOME/redshift/redshift.conf"

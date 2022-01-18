#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/config/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/config/zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/config/aliases" "$XDG_CONFIG_HOME/zsh/aliases"
ln -sf "$DOTFILES/zsh/config/dircolors" "$XDG_CONFIG_HOME/zsh/dircolors"
rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/config/external" "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/config/scripts.sh" "$XDG_CONFIG_HOME/zsh/scripts.sh"

#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/config/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/config/zprofile" "$XDG_CONFIG_HOME/zsh/.zprofile"
ln -sf "$DOTFILES/zsh/config/zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"
rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/config/external" "$XDG_CONFIG_HOME/zsh"

# If login shell is not zsh change it to zsh.
if [[ $SHELL =~ "zsh" ]]; then
    echo "Zsh is already the login shell."
else
    echo "Change the login shell to zsh."
    # Initiates a password prompt.
    chsh -s $(which zsh)
fi

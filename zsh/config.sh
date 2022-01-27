#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/config/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/config/zprofile" "$XDG_CONFIG_HOME/zsh/.zprofile"
ln -sf "$DOTFILES/zsh/config/zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/config/aliases.sh" "$XDG_CONFIG_HOME/zsh/aliases.sh"
ln -sf "$DOTFILES/zsh/config/dircolors" "$XDG_CONFIG_HOME/zsh/dircolors"
rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/config/external" "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/config/scripts.sh" "$XDG_CONFIG_HOME/zsh/scripts.sh"

# If login shell is not zsh change it to zsh.
if [[ $SHELL =~ "zsh" ]]; then
    echo "Zsh is already the login shell."
else
    echo "Change login shell to zsh."
    # Initiates a password prompt.
    chsh -s $(which zsh)
fi

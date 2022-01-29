#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/config/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/config/zprofile" "$XDG_CONFIG_HOME/zsh/.zprofile"
ln -sf "$DOTFILES/zsh/config/zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/config/dircolors" "$XDG_CONFIG_HOME/zsh/dircolors"

rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/config/external" "$XDG_CONFIG_HOME/zsh"

mkdir -p "$SCRIPTS_DIR"
ln -sf "$DOTFILES/zsh/config/aliases.sh" "$SCRIPTS_DIR/zsh-aliases.sh"
ln -sf "$DOTFILES/zsh/config/scripts.sh" "$SCRIPTS_DIR/zsh-scripts.sh"

# If login shell is not zsh change it to zsh.
if [[ $SHELL =~ "zsh" ]]; then
    echo "Zsh is already the login shell."
else
    echo "Change the login shell to zsh."
    # Initiates a password prompt.
    chsh -s $(which zsh)
fi

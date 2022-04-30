#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTMODULE/zsh/config/@env.zsh" "$XDG_CONFIG_HOME/zsh/.zshenv"
ln -sf "$DOTMODULE/zsh/config/@login.zsh" "$XDG_CONFIG_HOME/zsh/.zprofile"
ln -sf "$DOTMODULE/zsh/config/@interactive.zsh" "$XDG_CONFIG_HOME/zsh/.zshrc"
ln -sf "$XDG_CONFIG_HOME/zsh/.zshenv" "$HOME/.zshenv"

rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTMODULE/zsh/config/external" "$XDG_CONFIG_HOME/zsh"

# If login shell is not zsh change it to zsh.
if test "$SHELL" = "$(command -v zsh)"; then
    echo "Zsh is already the login shell."
else
    echo "Change the login shell to zsh."
    # Initiates a password prompt.
    chsh -s "$(command -v zsh)"
fi

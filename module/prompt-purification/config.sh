#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/zsh/interactive"
ln -sf "$DOTMODULE/prompt-purification/config/@interactive.zsh" "$XDG_CONFIG_HOME/zsh/interactive/prompt-purification.zsh"
mkdir -p "$XDG_CONFIG_HOME/zsh/function"
ln -sf "$DOTMODULE/prompt-purification/config/prompt_purification_setup.zsh" "$XDG_CONFIG_HOME/zsh/function/prompt_purification_setup"

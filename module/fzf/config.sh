#!/usr/bin/env sh
mkdir -p "$XDG_CONFIG_HOME/shell/env"
mkdir -p "$XDG_CONFIG_HOME/shell/interactive"
ln -sf "$DOTMODULE/fzf/config/@env.sh" "$XDG_CONFIG_HOME/shell/env/fzf.sh"

mkdir -p "$XDG_CONFIG_HOME/zsh/interactive/fzf"
ln -sf "$DOTMODULE/fzf/config/@interactive.zsh" "$XDG_CONFIG_HOME/zsh/interactive/fzf.zsh"
ln -sf "$DOTMODULE/fzf/config/completion.zsh" "$XDG_CONFIG_HOME/zsh/interactive/fzf/completion.zsh"
ln -sf "$DOTMODULE/fzf/config/key-bindings.zsh" "$XDG_CONFIG_HOME/zsh/interactive/fzf/key-bindings.zsh"

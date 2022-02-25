#!/bin/bash
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

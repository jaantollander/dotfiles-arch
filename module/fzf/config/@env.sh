# shellcheck shell=sh
export FZF_DEFAULT_COMMAND="fd --type file --hidden --color=always --exclude .git"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

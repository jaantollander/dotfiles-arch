# shellcheck shell=sh
export FZF_CTRL_T_COMMAND="fd --type file --hidden --color=always --exclude .git"
export FZF_CTRL_T_OPTS="--ansi"

export FZF_ALT_C_COMMAND="fd --type directory --hidden --color=always --exclude .git"
export FZF_ALT_C_OPTS="--ansi"

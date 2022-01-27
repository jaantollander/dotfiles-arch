#!/bin/bash 

## list directories
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

## list files
alias ls='ls --color=auto'
alias ll='ls -lah --group-directories-first'

## grep
alias grep='grep --color=auto'

# included aliases
source "$XDG_CONFIG_HOME/pacman/aliases.sh"
source "$XDG_CONFIG_HOME/yay/aliases.sh"
source "$XDG_CONFIG_HOME/tmux/aliases.sh"
source "$XDG_CONFIG_HOME/git/aliases.sh"

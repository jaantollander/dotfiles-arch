#!/bin/bash 

## list directories
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

## list files
# If we are not using `lsd` use stardard `ls` aliases.
if [[ ! $(command -v "lsd") ]]; then
    alias ls='ls --color=auto'
    alias l='ls -l'
    alias la='ls -a'
    alias ll='ls -lah'
fi

## grep
alias grep='grep --color=auto'

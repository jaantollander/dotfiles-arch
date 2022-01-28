#!/bin/bash 

## list directories
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

## list files
alias ls='ls --color=auto'
alias ll='ls -lah --group-directories-first'

## grep
alias grep='grep --color=auto'

# shellcheck shell=sh
if test "$(command -v "lsd")"; then
    alias ls='lsd'
    alias l='ls -l'
    alias la='ls -A'
    alias ll='ls -lA'
    alias lt='lsd --tree'
    alias lta='lt -A'
    alias ltl='lt -l'
    alias ltla='lt -lA'
fi

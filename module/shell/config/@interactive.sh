## Source other interactive scripts
INTERACTIVE=$XDG_CONFIG_HOME/shell/interactive
if [[ -d $INTERACTIVE && -n `ls $INTERACTIVE` ]]; then
    for x in $INTERACTIVE/*; do
        source $x
    done
fi

## Configure `ls` if `lsd` is not installed
if [[ ! $(command -v "lsd") ]]; then
    alias ls='ls --color=auto'
    alias l='ls -l'
    alias la='ls -a'
    alias ll='ls -lah'
fi

## Configure `grep`
alias grep='grep --color=auto'

## Keyboard layouts
alias us_kb='setxkbmap us'
alias fi_kb='setxkbmap fi'

## Aliases
alias tmuxl='tmux list-sessions'
alias tmuxa='tmux attach-session'
alias tmuxk='tmux kill-session'


## Functions
ftmuxp() {
    if [[ -n $TMUX ]]; then
        return
    fi
    
    # get the IDs
    ID="$(ls $XDG_CONFIG_HOME/tmuxp | sed -e 's/\.yml$//')"
    if [[ -z "$ID" ]]; then
        tmux new-session
    fi

    create_new_session="Create New Session"

    ID="${create_new_session}\n$ID"
    ID="$(echo $ID | fzf | cut -d: -f1)"

    if [[ "$ID" = "${create_new_session}" ]]; then
        tmux new-session
    elif [[ -n "$ID" ]]; then
        # Rename the current urxvt tab to session name
        #printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
        tmuxp load "$ID"
    fi
}
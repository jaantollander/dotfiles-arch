# shellcheck shell=sh
alias tmuxl='tmux list-sessions'
alias tmuxa='tmux attach-session'
alias tmuxk='tmux kill-session'


ftmuxp() {
    if test -n "$TMUX"; then
        return
    fi
    
    # get the IDs
    ID="$(ls "$XDG_CONFIG_HOME/tmuxp" | sed -e 's/\.yml$//')"
    if test -z "$ID"; then
        tmux new-session
    fi

    create_new_session="Create New Session"

    ID="${create_new_session}
$ID"
    ID="$(echo "$ID" | fzf | cut -d: -f1)"

    if test "$ID" = "${create_new_session}"; then
        tmux new-session
    elif test -n "$ID"; then
        tmuxp load "$ID"
    fi
}

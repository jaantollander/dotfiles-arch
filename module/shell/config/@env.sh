# Source environment variables
DIR=$HOME/.config/shell/env
if test -d $DIR; then
    for f in $DIR/*.sh; do
        test -r "$f" && . "$f"
    done
    unset f
fi
unset DIR

# Set the default editor
export EDITOR="nvim"
export VISUAL="nvim"

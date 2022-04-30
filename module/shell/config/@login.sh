# shellcheck shell=sh
# Source login scripts
DIR=$HOME/.config/shell/login
if test -d "$DIR"; then
    for f in "$DIR"/*.sh; do
        test -r "$f" && . "$f"
    done
    unset f
fi
unset DIR

# shellcheck shell=sh
# Source scripts for interactive shell
DIR=$HOME/.config/posix/interactive
if test -d "$DIR"; then
    for f in "$DIR"/*.sh; do
        test -r "$f" && . "$f"
    done
    unset f
fi
unset DIR

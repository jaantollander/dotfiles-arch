# shellcheck shell=sh

# Set default permissions to read and write for the user only
umask 077

# Source login scripts
DIR=$HOME/.config/posix/login
if test -d "$DIR"; then
    for f in "$DIR"/*.sh; do
        test -r "$f" && . "$f"
    done
    unset f
fi
unset DIR

# Append "$1" to $PATH when not already in.
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

append_path "$XDG_BIN_HOME"
export PATH

unset -f append_path

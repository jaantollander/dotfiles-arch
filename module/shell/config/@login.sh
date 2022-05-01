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

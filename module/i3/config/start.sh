# shellcheck shell=sh
if test ! "$(pidof -x i3)"; then
    exec i3
fi

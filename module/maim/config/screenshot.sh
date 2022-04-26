#!/usr/bin/env sh
mkdir -p "$HOME/screenshots"

if [ "$1" = "active-window" ]; then
    maim -i "$(xdottool getactivewindow)" "$HOME/screenshots/$(date -Iseconds).png"
fi

if [ "$1" = "active-display" ]; then
    maim -g "1920x1080-0+0" "$HOME/screenshots/$(date -Iseconds).png"
fi

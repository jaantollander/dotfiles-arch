#!/bin/sh

DIR=$HOME/.config/X11/xinitrc

if test -d "$DIR"; then
    # Merge xresources
    for f in "$DIR"/*.xresources; do
        test -r "$f" && xrdb -merge "$f"
    done
    # Source scripts
    for f in "$DIR"/*.sh; do
        test -r "$f" && . "$f"
    done
    unset f
fi

unset DIR

# TODO: change `ctrl_modifier` to Super_L
#setxkbmap -option 'caps:ctrl_modifier'
#xcape -e 'Caps_Lock=Escape' &

# Map Caps Lock to Escape
setxkbmap -option caps:escape

# Disable screen saver
xset s off
xset s noblank
xset -dpms

# Start Graphical User Interface (window manager or desktop environment)
START_GUI=$HOME/.config/X11/start_gui.sh

if test -r "$START_GUI"; then
    . "$START_GUI"
fi

unset START_GUI

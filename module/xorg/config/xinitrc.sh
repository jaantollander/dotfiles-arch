#!/bin/sh

DIR=$HOME/.config/X11/xinitrc

if [ -d $DIR ]; then
    # Merge xresources
    for f in $DIR/*.xresources; do
        [ -f $f ] && xrdb -merge $f
    done

    # Source scripts
    for f in $DIR/*.sh; do
        [ -f $f ] && . $f
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

# Start i3 window manager
exec i3

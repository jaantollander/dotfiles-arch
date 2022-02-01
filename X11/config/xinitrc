# Merge X11 style
xrdb -merge $HOME/.config/X11/style.xresources

# TODO: change `ctrl_modifier` to Super_L
#setxkbmap -option 'caps:ctrl_modifier'
#xcape -e 'Caps_Lock=Escape' &

# Map Caps Lock to Escape
setxkbmap -option caps:escape

# Disable screen saver
xset s off
xset s noblank
xset -dpms

# Merge URxvt settings
xrdb -merge $HOME/.config/urxvt/urxvt.xresources

# Start URxvt daemon
urxvtd -o -q -f

# Start i3 window manager
exec i3

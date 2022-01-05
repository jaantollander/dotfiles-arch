xrdb -merge $HOME/.config/X11/.Xresources
urxvtd -o -q -f

setxkbmap -option 'caps:ctrl_modifier';xcape -e 'Caps_Lock=Escape'&
# setxkbmap -option caps:escape

xset s off
xset s noblank
xset -dpms

udiskie &

exec i3

# If TTY is "tty1" and i3 is not started, start X11 which start i3.
if [[ "$(tty)" = "/dev/tty1" && -z $(pgrep i3) ]]; then
    exec startx "$XDG_CONFIG_HOME/X11/xinitrc.sh"
fi

screenshot_display() {
    mkdir -p $HOME/screenshots
    maim $HOME/screenshots/$(date -Iseconds).png 
}

screenshot_activewindow() {
    mkdir -p $HOME/screenshots
    maim -i $(xdottool getactivewindow) $HOME/screenshots/(date -Iseconds).png
}

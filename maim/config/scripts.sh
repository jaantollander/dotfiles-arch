#!/bin/bash

screenshot_display() {
    mkdir -p $HOME/screenshot
    maim $HOME/screenshot/$(date -Iseconds).png 
}

screenshot_activewindow() {
    mkdir -p $HOME/screenshot
    maim -i $(xdottool getactivewindow) $HOME/screenshot/(date -Iseconds).png
}

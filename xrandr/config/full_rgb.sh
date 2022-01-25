#!/bin/bash
# Set monitor to Full RGB (instead of limited RGB).
# - https://wiki.archlinux.org/title/Intel_graphics#Weathered_colors_(color_range_problems)
# - https://www.benq.eu/en-fi/knowledge-center/knowledge/full-rgb-vs-limited-rgb-is-there-a-difference.html
xrandr --output eDP-1 --set "Broadcast RGB" "Full"

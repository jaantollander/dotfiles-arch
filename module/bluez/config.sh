#!/usr/bin/env sh

# Enable bluetooth device if disabled
rfkill unblock bluetooth

# Start bluetooth daemon if it is not running yet.
if test ! "$(pidof -x bluetoothd)"; then
    systemctl enable "bluetooth.service" --now
fi

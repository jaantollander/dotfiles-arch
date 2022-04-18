#!/bin/bash
rfkill unblock bluetooth

# Start bluetooth daemon if it is not running yet.
if test ! $(pidof -x bluetoothd); then
    sudo systemctl enable --now bluetooth.service
fi

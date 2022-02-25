#!/bin/bash
rfkill unblock bluetooth

# Start bluetooth daemon if it is not running yet.
if [[ ! $(pgrep "bluetoothd") ]]; then
    sudo systemctl enable --now bluetooth.service
fi

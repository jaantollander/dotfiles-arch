#!/bin/bash
rfkill unblock bluetooth
sudo systemctl enable --now bluetooth.service

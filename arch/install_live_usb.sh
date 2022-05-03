#!/usr/bin/env sh

# Install Arch Linux Live USB
#
# USAGE
#   install_live_usb.sh <archiso> <usb-device>
#
# EXAMPLE
#   install_live_usb.sh archlinux-<version>-86_64.iso /dev/sdb
#
# LINKS
#   https://wiki.archlinux.org/title/USB_flash_installation_medium

# Path to the Arch Linux ISO file.
ARCHISO=$1

# Path to the USB device.
USB_DEVICE=$2

# Unmount all partitions of the USB device if they are mounted.
sudo umount "${USB_DEVICE}"*

# Wipe existing filesystem from the USB device.
sudo wipefs "$USB_DEVICE"

# Make FAT32 filesystem on the USB device.
sudo mkfs.fat -F 32 "$USB_DEVICE"

# Copy the Arch Linux ISO file to the USB device.
sudo dd if="$ARCHISO" of="$USB_DEVICE" bs=4M status=progress

# Finally, eject the USB device.
sudo eject "$USB_DEVICE"

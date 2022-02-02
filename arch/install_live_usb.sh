#!/bin/bash

## Usage
# bash install_live_usb.sh <arc_iso_path> <usb_device_path>

## Resources
# https://wiki.archlinux.org/title/USB_flash_installation_medium

# Path to the Arch Linux ISO file.
# Example: "~/downloads/archlinux-<version>-86_64.iso"
arch_iso=$1

# Path to the USB device.
# Example: `/dev/sdb`
# Use `lsblk` command to list block devices.
usb_device=$2

# Unmount all partitions of the USB device if they are mounted
umount ${usb_device}* 2> /dev/null

# Make FAT32 filesystem on the USB device
mkfs.fat -F 32 $usb_device 2> /dev/null

# Copy the Arch Linux ISO file to the USB device.
cat $arch_iso > $usb_device


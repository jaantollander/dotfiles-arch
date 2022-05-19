#!/usr/bin/env bash

# Script will fail if parameters are not set.
set -u
set -o pipefail

# Log stdout and stderr to files.
exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log" >&2)

# Print message to stdout
msg() { echo "MESSAGE: $*"; }

# Print error message
error() { echo "ERROR: $*"; } >&2

# Print error message and exit with error status
die() { error "$*"; exit 1; }

# Verify boot mode. Exit with error if not UEFI.
[ -d /sys/firmware/efi/efivars ] || die "Boot mode is not UEFI."

# Check network connection
ping -c 1 "archlinux.org" || die "Network connection failed."

# Verify that installation disk is valid block device
[ -b "$DISK" ] || die "DISK=\"$DISK\" is not valid block device."

# Set parameters
: "${SWAP_SIZE:="512M"}"
: "${HOST_NAME:="arch"}"
: "${USER_NAME:="jaan"}"
: "${TIMEZONE:="UTC"}"
: "${FONT:="ter-132n"}"

# Set up clock
timedatectl set-ntp true
hwclock --systohc --utc

# Wipe all data from the disk by overwriting it with zeros
dd if=/dev/zero of="$DISK" bs=4096 status=progress

# Clear existing partition data
sgdisk --clear "$DISK"

# Create EFI partition.
sgdisk --new "1::+512M" --typecode "1:ef00" "$DISK"

# Create Linux Filesystem partition for swap
sgdisk --new "2::+$SWAP_SIZE" --typecode "2:8300" "$DISK"

# Create Linux Filesystem partition for root
sgdisk --new "3::0" --typecode "3:8300" "$DISK"

# Update UUIDs for partitions, otherwise `genfstab` might use the old ones.
partprobe "$DISK"

# Match the partitions with a glob.
EFI=$(echo "$DISK"*1)
SWAP=$(echo "$DISK"*2)
ROOT=$(echo "$DISK"*3)

# Format the partitions
mkfs.fat -F32 "$EFI"
mkswap "$SWAP"
mkfs.ext4 "$ROOT"

# Mount the new system
mount "$ROOT" /mnt
swapon "$SWAP"
mkdir -p /mnt/boot/efi
mount "$EFI" /mnt/boot/efi

# Install Arch Linux
pacstrap /mnt \
    base base-devel grub efibootmgr linux linux-headers linux-firmware \
    dhcpcd iwd wpa_supplicant \
    git terminus-font

# Generate file system table
genfstab -U /mnt >> /mnt/etc/fstab

# Install GRUB on an UEFI computer
arch-chroot /mnt grub-install \
    --target=x86_64-efi \
    --efi-directory=/boot/efi \
    --bootloader-id=GRUB

# Generate GRUB configuration
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# Set hostname
echo "$HOST_NAME" > /mnt/etc/hostname

# Set virtual console font
echo "FONT=$FONT" > /mnt/etc/vconsole.conf

# Set the system clock
arch-chroot /mnt hwclock --systohc --utc
arch-chroot /mnt timedatectl set-timezone "$TIMEZONE"

# Set localization
echo "en_US.UTF-8 UTF-8" >> /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

# Set password for the root user
arch-chroot /mnt passwd

# Allow users on the "wheel" group to use "sudo"
echo "%wheel ALL=(ALL:ALL) ALL" > /mnt/etc/sudoers.d/wheel

# Create new user
arch-chroot /mnt useradd "$USER_NAME" \
    --create-home \
    --groups wheel \
    --shell /bin/bash
arch-chroot /mnt passwd "$USER_NAME"

# Network setup
arch-chroot /mnt systemctl enable "iwd.service" --now
arch-chroot /mnt systemctl enable "dhcpcd.service" --now
arch-chroot /mnt systemctl enable "systemd-networkd.socket" --now
arch-chroot /mnt systemctl enable "systemd-resolved.service" --now

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

# Verify that installation disk is valid block device
[ -b "$DISK" ] || die "DISK=\"$DISK\" is not valid block device."

# Set up clock
timedatectl set-ntp true
hwclock --systohc --utc

# Set your swap size such as "4G" or "512M".
: "${SWAP_SIZE:=512M}"
: "${HOST_NAME:=arch}"

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
pacstrap /mnt base base-devel grub efibootmgr linux linux-firmware

# Generate file system table
genfstab -U /mnt >> /mnt/etc/fstab

# Set hostname
echo "$HOST_NAME" > /mnt/etc/hostname

# Set hardware clock from system clock
ln -sf /usr/share/zoneinfo/UTC /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc --utc

# Set localization
echo "en_US.UTF-8 UTF-8" >> /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

# Set password for the root user
arch-chroot /mnt passwd

# Install GRUB on an UEFI computer
arch-chroot /mnt grub-install \
    --target=x86_64-efi \
    --efi-directory=/boot/efi \
    --bootloader-id=GRUB

# Generate GRUB configuration
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

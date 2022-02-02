#!/bin/bash

# This script is based on "Efficient UEFI Encrypted Root and Swap Arch Linux Installation 
# with an ENCRYPTED BOOT" by HardenedArray. 
# I highly recommend to read it for more detailed explanations.
# https://gist.github.com/HardenedArray/ee3041c04165926fca02deca675effe1


## --- Preparation ---
# 1) Create live bootable Arch Linux to USB stick.
# 2) Securely create three strong password for LUKS, root and user. Write them on paper.


## --- On Live Booted Arch Linux ---
# Connect to WiFi
iwctl

# Then to connect to your WiFi station
station <wlan-device-name> connect <wifi-station-name>

# Choose a hard disk. For example, "/dev/sda".
HARD_DISK="/dev/sdX"

# Create EFI and ROOT partitions
# - Partition 1: 100 MiB EFI partition. Hex code EF00
# - Partition 2: Choose a reasonable size for your encrypted root and swap system partition, 
#   or just size it to the last sector of your drive. Hex code 8300.  
gdisk $HARD_DISK

# We'll use the following variables to to denote the partitions.
EFI="${HARD_DISK}1"
ROOT="${HARD_DISK}2"

# Overwrite the partitions with zeros
cat /dev/zero $EFI
cat /dev/zero $ROOT

# Create FAT32 filesystem for the EFI partition 
mkfs.vfat -F 32 $EFI 

# Encrypt and open your system partition
EBOOT="encrypted-boot"
cryptsetup -c aes-xts-plain64 -h sha512 -s 512 --use-random --type luks1 luksFormat $ROOT
cryptsetup luksOpen $ROOT $EBOOT

# Create encrypted LVM partitions
pvcreate /dev/mapper/$EBOOT
vgcreate Arch /dev/mapper/$EBOOT
lvcreate -L 512M Arch -n swap
lvcreate -l 100%FREE Arch -n root

# Create filesystems on your encrypted partitions
mkswap /dev/mapper/Arch-swap
mkfs.ext4 /dev/mapper/Arch-root  

# Mount the new system
mount /dev/mapper/Arch-root /mnt
swapon /dev/mapper/Arch-swap
mkdir /mnt/boot
mkdir /mnt/efi
mount $EFI /mnt/efi

# Install Arch system
pacstrap /mnt base base-devel grub efibootmgr dialog wpa_supplicant linux linux-headers nvim dhcpcd iwd lvm2 linux-firmware man-pages

# Create and review file system table (fstab)
# The -U option pulls in all the correct UUIDs for your mounted filesystems.
genfstab -U /mnt >> /mnt/etc/fstab  

# Check your fstab carefully, and modify it, if required.
cat /mnt/etc/fstab  

# Enter the new system
arch-chroot /mnt /bin/bash

# Set the system clock
ln -s /usr/share/zoneinfo/UTC /etc/localtime  # This will harmlessly fail if your system's CMOS clock is already set to UTC.
hwclock --systohc --utc

#systemctl enable iwd

# Create a hostname
HOSTNAME="arch"
echo $HOSTNAME > /etc/hostname

# Set locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Set root password
passwd

# Create new user and set password
USERNAME="jaan"
useradd -m -G wheel -s /bin/bash $USERNAME
passwd $USERNAME 

# Let's create a crypto keyfile
cd /
dd bs=512 count=4 if=/dev/random of=crypto_keyfile.bin iflag=fullblock
chmod 000 /crypto_keyfile.bin
chmod 600 /boot/initramfs-linux*
cryptsetup luksAddKey $ROOT /crypto_keyfile.bin
cryptsetup luksDump $ROOT  # You should now see that LUKS Key Slots 0 and 1 are both occupied

# Configure mkinitcpio with the correct FILES statement and proper HOOKS required for your initrd image:
nvim /etc/mkinitcpio.conf
# Add the lines inside `` to the config.
# `FILES=(/crypto_keyfile.bin)`
# `HOOKS=(base udev autodetect modconf block keymap encrypt lvm2 resume filesystems keyboard fsck)`

# Generate your initrd image
mkinitcpio -p linux

# Install and Configure Grub-EFI
nvim /etc/default/grub
# Uncomment "GRUB_ENABLE_CRYPTODISK=y" in the config

# Install GRUB on an UEFI computer 
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux

# Edit the default grub
nvim /etc/default/grub
# Add the line inside `` and substitute the correct values for the variables.
# `GRUB_CMDLINE_LINUX="cryptdevice=/dev/$ROOT:$EBOOT resume=/dev/mapper/Arch-swap"`

# Generate Your Final Grub Configuration:
grub-mkconfig -o /boot/grub/grub.cfg

# Exit Your New Arch System
exit

# Unmount all partitions
umount -R /mnt
swapoff -a

# Reboot and Enjoy Your Encrypted BOOT Arch Linux System!
reboot

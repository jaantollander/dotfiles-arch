#!/usr/bin/env sh

# This script is based on "Efficient UEFI Encrypted Root and Swap Arch Linux Installation 
# with an ENCRYPTED BOOT" by HardenedArray. 
# I highly recommend to read it for more detailed explanations.
# https://gist.github.com/HardenedArray/ee3041c04165926fca02deca675effe1


## --- Preparation ---
# Securely create three strong password for LUKS, root and user. Write them on paper.


## --- On Live Booted Arch Linux ---
# Connect to WiFi if needed
# iwctl
# station <wlan-device-name> connect <wifi-station-name>

# Choose a hard disk.
# Example: "/dev/sda" or "/dev/nvme0n1"
HARD_DISK=""  

# Over write the hard disk
dd if=/dev/zero of="$HARD_DISK" bs=4M status=progress

# Create EFI and ROOT partitions
gdisk "$HARD_DISK"

# Clear all current partition data
# 1) `o`
# Create first partition for EFI.
# 2) `n`           Create new partition
# 3) `1`           Partition number
# 4) `<default>`   First sector
# 5) `+100M`       Last sector
# 6) `ef00`        Hex code for EFI partition type
# Create second partition for encrypted root and swap. 
# 7) `n`           Create new partition
# 8) `2`           Partition number
# 9) `<default>`   First sector
# 10) `<default>`  Last sector
# 11) `8300`       Linux filesystem partition type 
# Write partitions to disk
# 12) `w`

# We'll use the following variables to to denote the partitions.
EFI=""  # For example: "/dev/sda1" or "/dev/nvme0n1p1"
ROOT="" # For example: "/dev/sda2" or "/dev/nvme0n1p2"

# Create FAT32 filesystem for the EFI partition 
mkfs.vfat -F 32 "$EFI"

# Encrypt and open your system partition
EBOOT="encrypted-boot"
cryptsetup -c aes-xts-plain64 -h sha512 -s 512 --use-random --type luks1 luksFormat "$ROOT"
cryptsetup luksOpen "$ROOT" "$EBOOT"

# Create encrypted LVM partitions
LVGROUP="arch"
pvcreate /dev/mapper/$EBOOT
vgcreate $LVGROUP /dev/mapper/$EBOOT
lvcreate -L 512M $LVGROUP -n swap
lvcreate -l 100%FREE $LVGROUP -n root

# Create filesystems on your encrypted partitions
mkswap /dev/mapper/$LVGROUP-swap
mkfs.ext4 /dev/mapper/$LVGROUP-root  

# Mount the new system
mount /dev/mapper/$LVGROUP-root /mnt
swapon /dev/mapper/$LVGROUP-swap
mkdir /mnt/boot
mkdir /mnt/efi
mount "$EFI" /mnt/efi

# Install Arch system
pacstrap /mnt base base-devel grub efibootmgr dialog wpa_supplicant linux linux-headers nano dhcpcd iwd lvm2 linux-firmware man-pages

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
echo "arch" > /etc/hostname

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
cryptsetup luksAddKey "$ROOT" /crypto_keyfile.bin
cryptsetup luksDump "$ROOT"  # You should now see that LUKS Key Slots 0 and 1 are both occupied

# Configure mkinitcpio with the correct FILES statement and proper HOOKS required for your initrd image:
nano /etc/mkinitcpio.conf
# Add or modify the following lines to the config:
# FILES=(/crypto_keyfile.bin)
# HOOKS=(base udev autodetect modconf block keymap encrypt lvm2 resume filesystems keyboard fsck)

# Generate your initrd image
mkinitcpio -p linux

# Install and Configure Grub-EFI
nano /etc/default/grub
# Uncomment the following line in the config:
# GRUB_ENABLE_CRYPTODISK=y

# Install GRUB on an UEFI computer 
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux

# Edit the default grub
nano /etc/default/grub
# Substitute the correct values for the variables and add the line to the config:
# GRUB_CMDLINE_LINUX="cryptdevice=$ROOT:$EBOOT resume=/dev/mapper/$LVGROUP-swap"

# Generate Your Final Grub Configuration:
grub-mkconfig -o /boot/grub/grub.cfg

# Exit Your New Arch System
exit

# Unmount all partitions
umount -R /mnt
swapoff -a

# Reboot and Enjoy Your Encrypted BOOT Arch Linux System!
reboot

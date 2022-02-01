#!/bin/bash

## Info
# This script is based on "Efficient UEFI Encrypted Root and Swap Arch Linux Installation with an ENCRYPTED BOOT" by HardenedArray. I highly recommend to read it for more detailed explanations.
# https://gist.github.com/HardenedArray/ee3041c04165926fca02deca675effe1

## Choose a hard disk
HARD_DISK="/dev/sdX"
EFI="${HARD_DISK}Y"
ROOT="${HARD_DISK}Z"

## Create partitions
gdisk $HARD_DISK

# 1) Partition Y = 100 MiB EFI partition # Hex code EF00
# 2) Partition Z = Choose a reasonable size for your encrypted root and swap system partition, or just size it to the 
# last sector of your drive. # Hex code 8300.  

cat /dev/zero $EFI
cat /dev/zero $ROOT

mkfs.vfat -F 32 $EFI 
cryptsetup -c aes-xts-plain64 -h sha512 -s 512 --use-random --type luks1 luksFormat $ROOT

EBOOT="encrypted-boot"
cryptsetup luksOpen $ROOT $EBOOT

pvcreate /dev/mapper/$EBOOT
vgcreate Arch /dev/mapper/$EBOOT
lvcreate -L 512M Arch -n swap
lvcreate -l 100%FREE Arch -n root

mkswap /dev/mapper/Arch-swap
mkfs.ext4 /dev/mapper/Arch-root  
# mkfs.btrfs /dev/mapper/Arch-root

mount /dev/mapper/Arch-root /mnt
swapon /dev/mapper/Arch-swap
mkdir /mnt/boot
mkdir /mnt/efi
mount /dev/sdXY /mnt/efi

pacstrap /mnt base base-devel grub efibootmgr dialog wpa_supplicant linux linux-headers nano 
dhcpcd iwd lvm2 linux-firmware man-pages

genfstab -U /mnt >> /mnt/etc/fstab  # The -U option pulls in all the correct UUIDs for your mounted filesystems.
cat /mnt/etc/fstab  # Check your fstab carefully, and modify it, if required.

arch-chroot /mnt /bin/bash

ln -s /usr/share/zoneinfo/UTC /etc/localtime  # This will harmlessly fail if your system's CMOS clock is already set to UTC.
hwclock --systohc --utc

systemctl enable iwd

HOSTNAME="arch"
echo $HOSTNAME > /etc/hostname
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
nano /etc/mkinitcpio.conf
# FILES=(/crypto_keyfile.bin)
# HOOKS=(base udev autodetect modconf block keymap encrypt lvm2 resume filesystems keyboard fsck)

# Generate your initrd image
mkinitcpio -p linux

# Install and Configure Grub-EFI

# Since we need grub to decrypt our encrypted /boot, we first need to configure grub so that it knows we are working with
# a LUKS encrypted disk.
nano /etc/default/grub
# UNCOMMENT this line:
# GRUB_ENABLE_CRYPTODISK=y

# The correct way to install grub on an UEFI computer, irrespective of your use of a HDD or SSD, and whether you are
# installing dedicated Arch, or multi-OS booting, for our encrypted /boot purposes is:
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux

nano /etc/default/grub
# GRUB_CMDLINE_LINUX="cryptdevice=/dev/sdXZ:RockinEncryptedBoot resume=/dev/mapper/Arch-swap"

# Generate Your Final Grub Configuration:
grub-mkconfig -o /boot/grub/grub.cfg

# Exit Your New Arch System
exit

# Unmount all partitions
umount -R /mnt
swapoff -a

# Reboot and Enjoy Your Encrypted BOOT Arch Linux System!
reboot

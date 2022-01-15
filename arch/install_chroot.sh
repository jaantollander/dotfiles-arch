#!/bin/bash

hard_disk=$1
host_name=$2
boot_type=$3

## --- Install GRUB ---
pacman -S --noconfirm grub

if [ $boot_type = "uefi" ]; then
    pacman -S --noconfirm efibootmgr
    grub-install --target=x86_64-efi \
        --bootloader-id=GRUB \
        --efi-directory=/boot/efi
elif [ $boot_type = "bios" ]; then  
    grub-install "$hard_disk"
fi

grub-mkconfig -o /boot/grub/grub.cfg


## -- Set hostname ---
echo $host_name > /etc/hostname


## --- Set hardware clock from system clock ---
hwclock --systohc


## --- Set timezone ---
# To list the timezones: `timedatectl list-timezones`
timedatectl set-timezone "Europe/Helsinki"


# --- Set localization ---
# You can run `cat /etc/locale.gen` to see all the locales available
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf


## --- Set password for the root user ---
passwd 


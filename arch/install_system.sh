#!/bin/bash

## --- Set parameters ---
hard_disk=""
swap_size=""  # GBs
host_name=""

echo "Hard disk: $hard_disk"
echo "Swap size: $swap_size"
echo "Host name: $host_name"


## --- Enable network time synchronization --- 
timedatectl set-ntp true


## --- Boot type: BIOS or UEFI ---
if [ -f /sys/firmware/efi/efivars ]; then
    boot_type="uefi"
    boot_partition_type=1
else
    boot_type="bios"
    boot_partition_type=4
fi

echo "Boot type: $boot_type"


## --- Create the partitions ---
# g - create non empty GPT partition table
# n - create new partition
# p - primary partition
# e - extended partition
# w - write the table to disk and exit

partprobe "$hard_disk"

fdisk "$hard_disk" << EOF
g
n


+512M
t
$boot_partition_type
n


+${swap_size}G
n



w
EOF

partprobe "$hard_disk"


## --- Format the partitions ---
mkswap "${hard_disk}2"
swapon "${hard_disk}2"
mkfs.ext4 "${hard_disk}3"
mount "${hard_disk}3" /mnt

if [ $boot_type = "uefi" ]; then
    mkfs.fat -F32 "${hard_disk}1"
    mkdir -p /mnt/boot/efi
    mount "${hard_disk}1" /mnt/boot/efi
fi


## --- Install Arch Linux ---
pacstrap /mnt base base-devel linux linux-firmware


## --- Generate file system table ---
genfstab -U /mnt >> /mnt/etc/fstab


## --- Change root to /mnt ---
arch-chroot /mnt


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


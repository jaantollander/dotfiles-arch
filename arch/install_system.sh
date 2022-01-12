#!/bin/bash

# TODO: warning
# TODO: set parameters
hard_disk=""  # choose from `lsblk -d`
swap_size=""  # GBs
USER_NAME=""

timedatectl set-ntp true

# Verify boot (UEFI or BIOS)
uefi=0
ls /sys/firmware/efi/efivars 2> /dev/null && uefi=1

# Erase Disk
dd if=/dev/zero of=$hard_disk status=progress
# shred -v $hard_disk

boot_partition_type=1
[[ "$uefi" == 0 ]] && boot_partition_type=4

# Create the partitions

#g - create non empty GPT partition table
#n - create new partition
#p - primary partition
#e - extended partition
#w - write the table to disk and exit

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

# Format the partitions

mkswap "${hard_disk}2"
swapon "${hard_disk}2"
mkfs.ext4 "${hard_disk}3"
mount "${hard_disk}3" /mnt

if [ "$uefi" = 1 ]; then
    mkfs.fat -F32 "${hard_disk}1"
    mkdir -p /mnt/boot/efi
    mount "${hard_disk}1" /mnt/boot/efi
fi

# Install Arch Linux! Glory and fortune!
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

# Change root to /mnt
arch-chroot /mnt

# Install GRUB
pacman -S --noconfirm grub

if [ "$uefi" = 1 ]; then
    pacman -S --noconfirm efibootmgr
    grub-install --target=x86_64-efi \
        --bootloader-id=GRUB \
        --efi-directory=/boot/efi
else
    grub-install "$hard_disk"
fi

grub-mkconfig -o /boot/grub/grub.cfg

# Set hardware clock from system clock
hwclock --systohc

# To list the timezones: `timedatectl list-timezones`
timedatectl set-timezone "Europe/Helsinki"

# Replace en_US.UTF-8 by whatever locale you want.
# You can run `cat /etc/locale.gen` to see all the locales available
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

useradd -m -g wheel -s /bin/bash "root"
# TODO: set password

useradd -m -g wheel -s /bin/bash "$USER_NAME"
# TODO: set password


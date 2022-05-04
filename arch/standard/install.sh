#!/usr/bin/env sh

## --- Parameters ---
# Select the hard drive to install Arch Linux such as "/dev/sda" or `/dev/nvme0n1`. 
# Use `lsblk -d` to list your block devices.
HARD_DISK=""

# Set your swap size such as "4G" or "512M".
SWAP_SIZE=""


## --- Connect to the Internet ---
# Make sure you are connected to the internet via ethernet cable or wi-fi.

# You can use `iwctl` to connect to wi-fi.
# iwctl
# station <wlan-device-name> connect <wifi-station-name>


## --- Wipe the hard drive ---
dd if=/dev/zero of="$HARD_DISK" bs=4M status=progress


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

partprobe "$HARD_DISK"

fdisk "$HARD_DISK" << EOF
g
n


+512M
t
$boot_partition_type
n


+${SWAP_SIZE}
n



w
EOF

partprobe "$HARD_DISK"


## --- Format the partitions ---
mkswap "${HARD_DISK}2"
swapon "${HARD_DISK}2"
mkfs.ext4 "${HARD_DISK}3"
mount "${HARD_DISK}3" /mnt

if [ $boot_type = "uefi" ]; then
    mkfs.fat -F32 "${HARD_DISK}1"
    mkdir -p /mnt/boot/efi
    mount "${HARD_DISK}1" /mnt/boot/efi
fi


## --- Install Arch Linux ---
pacstrap /mnt base base-devel linux linux-firmware


## --- Generate file system table ---
genfstab -U /mnt >> /mnt/etc/fstab


## --- Enter the new system ---
arch-chroot /mnt /bin/bash


## --- Install GRUB ---
pacman -S --noconfirm grub

if [ $boot_type = "uefi" ]; then
    pacman -S --noconfirm efibootmgr
    grub-install --target=x86_64-efi \
        --bootloader-id=GRUB \
        --efi-directory=/boot/efi
elif [ $boot_type = "bios" ]; then  
    grub-install "$HARD_DISK"
fi

grub-mkconfig -o /boot/grub/grub.cfg


## -- Set hostname ---
echo "arch" > /etc/hostname


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


## --- Create a new user and set password ---
USERNAME="jaan"
useradd -m -g wheel -s /bin/bash "$USERNAME"
passwd "$USERNAME"

# Exit your system
exit

# Unmount all partitions
umount -R /mnt
swapoff -a

# Reboot your system
reboot

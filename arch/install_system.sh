#!/bin/bash

## --- Usage ---
# Make sure you are connected to the internet via ethernet cable or wi-fi.
# You can use `iwctl` to connect to wi-fi.
#
# Use the script as follows 
# `bash install_system.sh <hard-disk> <swap-size> <host-name>`
#
# Example:
# `bash install_system.sh "/dev/nvme0n1" "4G" "arch"`

## --- Set parameters ---
# Select the hard drive to install Arch Linux such as "/dev/sda" or `/dev/nvme0n1`. 
# Use `lsblk -d` to list your block devices.
hard_disk=$1  

# Set you swap size such as "4G" or "512M".
swap_size=$2

# Set a (host)name for your computer, such as "arch".
host_name=$3  

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


+${swap_size}
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
arch-chroot /mnt bash install_chroot.sh $hard_disk $host_name $boot_type


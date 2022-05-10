#!/usr/bin/env sh

# Create EFI and ROOT partitions using `gdisk`.
# 1.
#   `o`           Clear all current partition data
#   `y`           Accept
# 2. Create first partition for EFI.
#   `n`           Create new partition
#   `1`           Partition number
#   `<default>`   First sector
#   `+100M`       Last sector
#   `ef00`        Hex code for EFI partition type
# 3. Create second partition for encrypted root and swap.
#   `n`           Create new partition
#   `2`           Partition number
#   `<default>`   First sector
#   `<default>`   Last sector
#   `8300`        Linux filesystem partition type
# 4.
#   `w`           Write partitions to disk
#   `y`           Accept

# TODO: replace with sgdisk
gdisk "$DISK" << EOF
o
y
n
1

+100M
ef00
n
2


8300
w
y
EOF

# Verify that EFI and ROOT block devices exist
[ -b "$EFI" ] || return 1
[ -b "$ROOT" ] || return 1

# Create FAT32 filesystem for the EFI partition
mkfs.vfat -F 32 "$EFI"

# Encrypt and open your system partition
cryptsetup \
    -c aes-xts-plain64 \
    -h sha512 \
    -s 512 \
    --use-random \
    --type luks1 \
    luksFormat "$ROOT"
cryptsetup luksOpen "$ROOT" "$EBOOT"

# Create encrypted LVM partitions
pvcreate "/dev/mapper/$EBOOT"
vgcreate "$LVGROUP" "/dev/mapper/$EBOOT"
lvcreate -L 512M "$LVGROUP" -n swap
lvcreate -l 100%FREE "$LVGROUP" -n root

# Create filesystems on your encrypted partitions
mkswap "/dev/mapper/$LVGROUP-swap"
mkfs.ext4 "/dev/mapper/$LVGROUP-root"

# Mount the new system
mount "/dev/mapper/$LVGROUP-root" /mnt
swapon "/dev/mapper/$LVGROUP-swap"
mkdir /mnt/boot
mkdir /mnt/efi
mount "$EFI" /mnt/efi

# Install Arch system
pacstrap /mnt \
    base base-devel grub efibootmgr dialog wpa_supplicant linux \
    linux-headers dhcpcd iwd lvm2 linux-firmware man-pages

# Create and review file system table (fstab)
# The -U option pulls in all the correct UUIDs for your mounted filesystems.
# FIXME: generated fstab has incorrect UUID for \efi
genfstab -U /mnt >> /mnt/etc/fstab

# Check your fstab carefully, and modify it, if required.
# UUIDs should match ones in "/dev/disk/by-uuid/"
cat /mnt/etc/fstab
ls -l /mnt/dev/disk/by-uuid/

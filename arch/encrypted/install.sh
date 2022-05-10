#!/usr/bin/env bash

# Script will fail if parameters are not set.
set -u
set -o pipefail

# Log stdout and stderr to files.
exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log" >&2)

# Verify boot mode. Exit with error if not UEFI.
if [ ! -d /sys/firmware/efi/efivars ]; then
    echo >&2 "Boot mode is not UEFI."
    exit 2
fi

# Set a hard disk for installation such as "/dev/sda" or "/dev/nvme0n1"
# as an environment variable. 
# export DISK=/dev/sda
if [ ! -b "$DISK" ]; then
    echo >&2 "DISK=\"$DISK\" is not valid block device."
    exit 2
fi

# We'll use the following variables to to denote the partitions.
case "$DISK" in
    /dev/sd*)
        EFI="${DISK}1"
        ROOT="${DISK}2"
        ;;
    /dev/nvme*)
        EFI="${DISK}p1"
        ROOT="${DISK}p2"
        ;;
    *)
        echo >&2 "Couldn't set EFI and ROOT."
        exit 2
        ;;
esac

EBOOT="encrypted-boot"
LVGROUP="arch"

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
# FIXME: generated fstab has incorrect UUID for "\efi
genfstab -U /mnt >> /mnt/etc/fstab

# Check your fstab carefully, and modify it, if required.
# UUIDs should match ones in "/dev/disk/by-uuid/"
cat /mnt/etc/fstab
arch-chroot /mnt ls -l /dev/disk/by-uuid/

# Set the system clock
# This will harmlessly fail if your system's CMOS clock is already set to UTC.
ln -sf /usr/share/zoneinfo/UTC /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc --utc

# Create a hostname
echo "arch" > /mnt/etc/hostname

# Set locale
echo "en_US.UTF-8 UTF-8" >> /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

# Set root password
arch-chroot /mnt passwd

# Let's create a crypto keyfile
dd bs=512 count=4 if=/dev/random of=/mnt/crypto_keyfile.bin iflag=fullblock
chmod 000 /mnt/crypto_keyfile.bin
chmod 600 /mnt/boot/initramfs-linux*
cryptsetup luksAddKey "$ROOT" /mnt/crypto_keyfile.bin

# You should now see that LUKS Key Slots 0 and 1 are both occupied
cryptsetup luksDump "$ROOT"

# Configure mkinitcpio with the correct FILES statement and proper HOOKS required for your initrd image
# Backup the default mkinitcpio.conf and create new.
cp /mnt/etc/mkinitcpio.conf /mnt/etc/mkinitcpio.conf.old
cat << EOF > /mnt/etc/mkinitcpio.conf
MODULES=()
BINARIES=()
FILES=(/crypto_keyfile.bin)
HOOKS=(base udev autodetect modconf block keymap encrypt lvm2 resume filesystems keyboard fsck)
EOF

# Generate your initrd image
arch-chroot /mnt mkinitcpio -p linux

# Install and Configure Grub-EFI
# Uncomment the following line in "/etc/default/grub".
# GRUB_ENABLE_CRYPTODISK=y
M1='^#\?GRUB_ENABLE_CRYPTODISK=.*$'
R1="GRUB_ENABLE_CRYPTODISK=y"
sed -i -e "s@$M1@$R1@g" /mnt/etc/default/grub

# Avoid leaking variables
unset M1 R1

# Install GRUB on an UEFI computer
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux

# Edit the default grub
# Substitute the correct values for the variables and add the line to "/etc/default/grub".
# GRUB_CMDLINE_LINUX="cryptdevice=$ROOT:$EBOOT resume=/dev/mapper/$LVGROUP-swap"
M2='^GRUB_CMDLINE_LINUX=.*$'
R2="GRUB_CMDLINE_LINUX=\"cryptdevice=$ROOT:$EBOOT resume=/dev/mapper/$LVGROUP-swap\""
sed -i -e "s@$M2@$R2@g" /mnt/etc/default/grub

# Avoid leaking variables
unset M2 R2

# Generate Your Final Grub Configuration:
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# Unmount all partitions and reboot
#umount -R /mnt
#swapoff -a
#reboot

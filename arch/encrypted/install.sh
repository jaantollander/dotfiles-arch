#!/usr/bin/env bash

# This script is based on "Efficient UEFI Encrypted Root and Swap Arch Linux Installation
# with an ENCRYPTED BOOT" by HardenedArray.
# I highly recommend to read it for more detailed explanations.
# https://gist.github.com/HardenedArray/ee3041c04165926fca02deca675effe1


prepare_hard_disk() {
    local HARD_DISK=$1
    local EFI=$2
    local ROOT=$3
    local EBOOT=$4
    local LVGROUP=$5

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

    gdisk "$HARD_DISK" << EOF
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
    [ -b "$EFI" ] || exit 1
    [ -b "$ROOT" ] || exit 1

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
    genfstab -U /mnt >> /mnt/etc/fstab

    # Check your fstab carefully, and modify it, if required.
    #cat /mnt/etc/fstab
}


install_system() {
    ROOT=$1
    EBOOT=$2
    LVGROUP=$3

    # Set the system clock
    # This will harmlessly fail if your system's CMOS clock is already set to UTC.
    ln -s /usr/share/zoneinfo/UTC /etc/localtime
    hwclock --systohc --utc

    # Create a hostname
    echo "arch" > /etc/hostname

    # Set locale
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf

    # Set root password
    passwd

    # Let's create a crypto keyfile
    cd /
    dd bs=512 count=4 if=/dev/random of=crypto_keyfile.bin iflag=fullblock
    chmod 000 /crypto_keyfile.bin
    chmod 600 /boot/initramfs-linux*
    cryptsetup luksAddKey "$ROOT" /crypto_keyfile.bin
    cryptsetup luksDump "$ROOT"
    # You should now see that LUKS Key Slots 0 and 1 are both occupied

    # Configure mkinitcpio with the correct FILES statement and proper HOOKS required for your initrd image:
    # Add or modify the following lines in "/etc/mkinitcpio.conf".
    # FILES=(/crypto_keyfile.bin)
    # HOOKS=(base udev autodetect modconf block keymap encrypt lvm2 resume filesystems keyboard fsck)

    local MATCH_FILES='^FILES=.*$'
    local FILES='FILES=(/crypto_keyfile.bin)'

    local MATCH_HOOKS='^HOOKS=.*$'
    local HOOKS='HOOKS=(base udev autodetect modconf block keymap encrypt lvm2 resume filesystems keyboard fsck)'

    sed -e "s@$MATCH_FILES@$FILES@g" \
        -e "s@$MATCH_HOOKS@$HOOKS@g" \
        --in-place \
        /etc/mkinitcpio.conf

    # Generate your initrd image
    mkinitcpio -p linux

    # Install and Configure Grub-EFI
    # Uncomment the following line in "/etc/default/grub".
    # GRUB_ENABLE_CRYPTODISK=y

    local MATCH_GRUB_ENABLE_CRYPTODISK='^#\?GRUB_ENABLE_CRYPTODISK=.*$'
    local GRUB_ENABLE_CRYPTODISK="GRUB_ENABLE_CRYPTODISK=y"
    sed -e "s@$MATCH_GRUB_ENABLE_CRYPTODISK@$GRUB_ENABLE_CRYPTODISK@g" \
        --in-place \
        /etc/default/grub

    # Install GRUB on an UEFI computer
    grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux

    # Edit the default grub
    # Substitute the correct values for the variables and add the line to "/etc/default/grub".
    # GRUB_CMDLINE_LINUX="cryptdevice=$ROOT:$EBOOT resume=/dev/mapper/$LVGROUP-swap"

    local MATCH_GRUB_CMDLINE_LINUX='^GRUB_CMDLINE_LINUX=.*$'
    local GRUB_CMDLINE_LINUX="GRUB_CMDLINE_LINUX=\"cryptdevice=$ROOT:$EBOOT resume=/dev/mapper/$LVGROUP-swap\""
    sed -e "s@$MATCH_GRUB_CMDLINE_LINUX@$GRUB_CMDLINE_LINUX@g" \
        --in-place \
        /etc/default/grub

    # Generate Your Final Grub Configuration:
    grub-mkconfig -o /boot/grub/grub.cfg
}


# Verify boot mode. Exit with error if not UEFI.
[ -d /sys/firmware/efi/efivars ] || exit 1

# Set a hard disk for installation such as "/dev/sda" or "/dev/nvme0n1"
# as an environment variable. 
# export HARD_DISK=/dev/sda
[ -b "$HARD_DISK" ] || exit 1

# We'll use the following variables to to denote the partitions.
case "$HARD_DISK" in
    "/dev/sd"*)
        EFI="${HARD_DISK}1"
        ROOT="${HARD_DISK}2"
        ;;
    "/dev/nvme"*)
        EFI="${HARD_DISK}p1"
        ROOT="${HARD_DISK}p2"
        ;;
    *) exit 1
        ;;
esac

EBOOT="encrypted-boot"
LVGROUP="arch"

export HARD_DISK EFI ROOT EBOOT LVGROUP

step1() {
    prepare_hard_disk "$HARD_DISK" "$EFI" "$ROOT" "$EBOOT" "$LVGROUP"
}

step2() {
    arch-chroot /mnt install_system "$ROOT" "$EBOOT" "$LVGROUP"
}

step3() {
    # Unmount all partitions and reboot
    umount -R /mnt
    swapoff -a
    reboot
}

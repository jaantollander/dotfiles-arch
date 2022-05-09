#!/usr/bin/env sh

# Verify boot mode. Exit with error if not UEFI.
if [ ! -d /sys/firmware/efi/efivars ]; then
    echo "Boot mode is not UEFI."
    return 1
fi

# Set a hard disk for installation such as "/dev/sda" or "/dev/nvme0n1"
# as an environment variable. 
# export HARD_DISK=/dev/sda
if [ ! -b "$HARD_DISK" ]; then
    echo "HARD_DISK=\"$HARD_DISK\" is not valid block device."
    return 1
fi

# We'll use the following variables to to denote the partitions.
case "$HARD_DISK" in
    /dev/sd*)
        EFI="${HARD_DISK}1"
        ROOT="${HARD_DISK}2"
        ;;
    /dev/nvme*)
        EFI="${HARD_DISK}p1"
        ROOT="${HARD_DISK}p2"
        ;;
    *)
        echo "Couldn't set EFI and ROOT."
        return 1
        ;;
esac

EBOOT="encrypted-boot"
LVGROUP="arch"

export HARD_DISK EFI ROOT EBOOT LVGROUP

step1() {
    chmod u+x disk.sh
    ./disk.sh
}

step2() {
    chmod u+x system.sh
    cp system.sh /mnt/system.sh
    arch-chroot /mnt /system.sh
    rm /mnt/system.sh
}

step3() {
    # Unmount all partitions and reboot
    umount -R /mnt
    swapoff -a
    reboot
}

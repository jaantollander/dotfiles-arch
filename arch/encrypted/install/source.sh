#!/usr/bin/env sh

# Verify boot mode. Exit with error if not UEFI.
if [ ! -d /sys/firmware/efi/efivars ]; then
    echo "Boot mode is not UEFI."
    return 1
fi

# Set a hard disk for installation such as "/dev/sda" or "/dev/nvme0n1"
# as an environment variable. 
# export DISK=/dev/sda
if [ ! -b "$DISK" ]; then
    echo "DISK=\"$DISK\" is not valid block device."
    return 1
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
        echo "Couldn't set EFI and ROOT."
        return 1
        ;;
esac

EBOOT="encrypted-boot"
LVGROUP="arch"

export DISK EFI ROOT EBOOT LVGROUP

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

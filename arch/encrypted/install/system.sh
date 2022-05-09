#!/usr/bin/env sh

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

MATCH_FILES='^FILES=.*$'
FILES='FILES=(/crypto_keyfile.bin)'

MATCH_HOOKS='^HOOKS=.*$'
HOOKS='HOOKS=(base udev autodetect modconf block keymap encrypt lvm2 resume filesystems keyboard fsck)'

sed -e "s@$MATCH_FILES@$FILES@g" \
    -e "s@$MATCH_HOOKS@$HOOKS@g" \
    --in-place \
    /etc/mkinitcpio.conf

# Generate your initrd image
mkinitcpio -p linux

# Install and Configure Grub-EFI
# Uncomment the following line in "/etc/default/grub".
# GRUB_ENABLE_CRYPTODISK=y

MATCH_GRUB_ENABLE_CRYPTODISK='^#\?GRUB_ENABLE_CRYPTODISK=.*$'
GRUB_ENABLE_CRYPTODISK="GRUB_ENABLE_CRYPTODISK=y"

sed -e "s@$MATCH_GRUB_ENABLE_CRYPTODISK@$GRUB_ENABLE_CRYPTODISK@g" \
    --in-place \
    /etc/default/grub

# Install GRUB on an UEFI computer
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux

# Edit the default grub
# Substitute the correct values for the variables and add the line to "/etc/default/grub".
# GRUB_CMDLINE_LINUX="cryptdevice=$ROOT:$EBOOT resume=/dev/mapper/$LVGROUP-swap"

MATCH_GRUB_CMDLINE_LINUX='^GRUB_CMDLINE_LINUX=.*$'
GRUB_CMDLINE_LINUX="GRUB_CMDLINE_LINUX=\"cryptdevice=$ROOT:$EBOOT resume=/dev/mapper/$LVGROUP-swap\""

sed -e "s@$MATCH_GRUB_CMDLINE_LINUX@$GRUB_CMDLINE_LINUX@g" \
    --in-place \
    /etc/default/grub

# Generate Your Final Grub Configuration:
grub-mkconfig -o /boot/grub/grub.cfg

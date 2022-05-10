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
dd bs=512 count=4 if=/dev/random of=/crypto_keyfile.bin iflag=fullblock
chmod 000 /crypto_keyfile.bin
chmod 600 /boot/initramfs-linux*
cryptsetup luksAddKey "$ROOT" /crypto_keyfile.bin
cryptsetup luksDump "$ROOT"
# You should now see that LUKS Key Slots 0 and 1 are both occupied

# Configure mkinitcpio with the correct FILES statement and proper HOOKS required for your initrd image
# Backup the default mkinitcpio.conf and create new.
cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.old
cat << EOF > /etc/mkinitcpio.conf
MODULES=()
BINARIES=()
FILES=(/crypto_keyfile.bin)
HOOKS=(base udev autodetect modconf block keymap encrypt lvm2 resume filesystems keyboard fsck)
EOF

# Generate your initrd image
mkinitcpio -p linux

# Install and Configure Grub-EFI
# Uncomment the following line in "/etc/default/grub".
# GRUB_ENABLE_CRYPTODISK=y
M1='^#\?GRUB_ENABLE_CRYPTODISK=.*$'
R1="GRUB_ENABLE_CRYPTODISK=y"
sed -i -e "s@$M1@$R1@g" /etc/default/grub

# Avoid leaking variables
unset M1 R1

# Install GRUB on an UEFI computer
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux

# Edit the default grub
# Substitute the correct values for the variables and add the line to "/etc/default/grub".
# GRUB_CMDLINE_LINUX="cryptdevice=$ROOT:$EBOOT resume=/dev/mapper/$LVGROUP-swap"
M2='^GRUB_CMDLINE_LINUX=.*$'
R2="GRUB_CMDLINE_LINUX=\"cryptdevice=$ROOT:$EBOOT resume=/dev/mapper/$LVGROUP-swap\""
sed -i -e "s@$M2@$R2@g" /etc/default/grub

# Avoid leaking variables
unset M2 R2

# Generate Your Final Grub Configuration:
grub-mkconfig -o /boot/grub/grub.cfg

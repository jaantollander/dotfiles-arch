# Instructions
## About
My arch install script are influenced by the following resources.

- [The official installation guide](https://wiki.archlinux.org/title/installation_guide)
- [Phantas0s/ArchInstall](https://github.com/Phantas0s/ArchInstall)
- [maximbaz/dotfiles](https://github.com/maximbaz/dotfiles)/[`install.sh`](https://github.com/maximbaz/dotfiles/blob/master/install.sh)
- ["Efficient UEFI Encrypted Root and Swap Arch Linux Installation with an ENCRYPTED BOOT" by HardenedArray](https://gist.github.com/HardenedArray/ee3041c04165926fca02deca675effe1)


## Installing Live USB
Download Arch Linux ISO file from the Arch Linux website. After the download, there should exist an ISO file as below. 

```bash
ls archlinux-2022.01.01-x86_64.iso
```

Next, attach a USB drive to the computer and list block devices. The USB device should be listed. In the example, below is named `sdb` with partitions `1` and `2`. The block devices listed above are located in the `/dev/` directory. The path to the `sdb` is therefore `/dev/sdb`.

```bash
lsblk
```

```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    1     0B  0 disk
sdb           8:16   1  57.8G  0 disk
├─sdb1        8:17   1   790M  0 part
└─sdb2        8:18   1    74M  0 part
nvme0n1     259:0    0 476.9G  0 disk
├─nvme0n1p1 259:1    0   512M  0 part /boot/efi
├─nvme0n1p2 259:2    0     4G  0 part [SWAP]
└─nvme0n1p3 259:3    0 472.4G  0 part /
```

Finally, let's install the live bootable Arch Linux on USB drive. We need to supply the path to the Arch Linux ISO file and path to the USB device to the script.

```bash
ARCHISO=archlinux-2022.01.01-x86_64.iso
sh live_usb.sh $ARCHISO /dev/sdb
```

We can now remove the USB drive and attach it to the computer where we want to boot Arch Linux as Live USB environment for installation. Modify the boot order such that the USB drive is the first to boot. Now, we can boot to the live Arch Linux environment!


## Installing Encrypted System
Prepapare by securely creating strong passwords for LUKS and root. Write them on paper.

Lets change larger font on the Linux console to make text easier to read.

```bash
setfont ter-132n
```

Connect to the internet via ethernet or WiFi. We can use `iw` for connecting to WiFi if needed.

```bash
iwctl station list
iwctl station <wlan> scan
iwctl station <wlan> get-networks
iwctl station <wlan> connect <network-name>
```

Download the installation script.

```bash
curl https://raw.githubusercontent.com/jaantollander/dotfiles/master/arch/encrypted/install.sh > install.sh
```

List your block devices and select the hard drive to install the operating system.

```bash
lsblk -d
```

Export the selected hard drive as an environment variable such as `/dev/sda` or `/dev/nvme0n1`.

```bash
export DISK=/dev/nvme0n1
```

Remove existing filesystems from the disk and overwrite it with zeros to wipe all data from it.

```bash
wipefs -a "$DISK"
dd if=/dev/zero of="$DISK" bs=4M status=progress
```

Run the installation script. For the script to work, the `DISK` environment variable must be set.

```bash
bash install.sh
```

Finally, unmount all partitions and reboot.

```bash
umount -R /mnt
swapoff -a
reboot
```


## Post Installation Steps
First, log into the `root` user. Then, enable internet by plugging ethernet cable or using wi-fi. Let's start the `iw` and `dhcpc` daemons.

```bash
systemctl enable iwd --now
systemctl enable networkd --now
systemctl enable resolved --now
#dhcpcd &
```

We can connect to wi-fi using `iwctl`.

```bash
iwctl
```

List available timezones and set a new timezone if needed.

```bash
timedatectl list-timezones
timedatectl set-timezone "Europe/Helsinki"
```

Next, we need to install Git and text editor such as Neovim for editing configuration files.

```bash
pacman -Suy git neovim
```

Let's securely edit the `/etc/sudoers` file `visudo` to allow users on the `wheel` group to use `sudo` by uncommenting the line `%wheel ALL=(ALL:ALL) ALL`.

```bash
export EDITOR=nvim
visudo
```

Next, let's change the default `umask 022` to `umask 077` which improves security by changing the default file permissions to read and write and additionally execute permission to directories only for the owner. 

```bash
nvim /etc/profile
```

Create new user

```bash
USERNAME="jaan"
useradd -m -G wheel -s /bin/bash "$USERNAME"
passwd "$USERNAME"
```

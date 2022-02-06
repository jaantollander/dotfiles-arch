# Instructions
## Installing Live USB
Download Arch Linux ISO file from the Arch Linux website. After the download, there should exist an ISO file as below. 

```bash
ls ~/downloads/archlinux-2022.01.01-x86_64.iso
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
bash install_live_usb.sh ~/downloads/archlinux-2022.01.01-x86_64.iso /dev/sdb
```

We can now remove the USB drive and attach it to the computer where we want to boot Arch Linux as Live USB environment for installation. Modify the boot order such that the USB drive is the first to boot. Now, we can boot to the live Arch Linux environment!


## Installing System
We can follow the instructions on the [`install_system.sh`](./install_system.sh) file for normal system installation or the instructions on the [`install_system_encrypted.sh`](./install_system_encrypted.sh) file for installing system with encrypted boot and hard drive.


## Post Installation
Log into the `root` user and enable internet.

```bash
systemctl enable iwd --now
dhcpcd &
iwctl
```

Install Git and Neovim.

```bash
pacman -Suy git neovim
```

Edit the `/etc/sudoers` file.

```bash
export EDITOR=nvim
visudo
```

Uncomment the line `%wheel ALL=(ALL:ALL) ALL`.

```bash
nvim /etc/profile
```

Change `umask 022` to `umask 077`.


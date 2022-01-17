# Instructions
## 1. Installing Live USB
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

We can now remove the USB drive and attach it to the computer where we want to boot Arch Linux as Live USB environment for installation.


## 2. Install System
Let's boot Arch Linux from the USB. First, we need to configure network connection. Either, plug an ethernet cable or connect to wi-fi via `iwctl`. Now, we can download the installation scripts.

```bash
curl https://raw.githubusercontent.com/jaantollander/dotfiles/master/arch/erase_hard_disk.sh > erase_hard_disk.sh
curl https://raw.githubusercontent.com/jaantollander/dotfiles/master/arch/install_system.sh > install_system.sh
curl https://raw.githubusercontent.com/jaantollander/dotfiles/master/arch/install_chroot.sh > install_chroot.sh
```

Next, we need to list our block devices to location of the hard drive. In this case it is `nvme0n1` and the to it is `/dev/nvme0n1`.

```bash
lsblk -d
```

```
NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda       8:0    1     0B  0 disk
nvme0n1 259:0    0 476.9G  0 disk
```

We can erase the hard disk before installing the operating system on it, by overwriting the disk with zeros.

```bash
bash erase_hard_disk.sh "/dev/nvme0n1" "zeros"
```

Finally, we can run the system install script with arguments fort hard disk, swap size and hostname.

```bash
bash install_system.sh "/dev/nvme0n1" "4G" "arch"
```

After the installation, we can reboot the computer.

```bash
reboot
```


## 3. Adding Users
After rebooting to our freshly installed Arch Linux, we need to add a new user for us to use. Let's download the script for adding new users.

```bash
curl https://github.com/jaantollander/dotfiles/blob/master/arch/add_new_user.sh > add_new_user.sh
```

Now, we can create new user as below, simply substitute `<username>` with the desired username.

```bash
bash add_new_user.sh <username>
```


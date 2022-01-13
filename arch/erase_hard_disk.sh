#!/bin/bash

# Choose a hard disk to erase.
# You can list your hard disks using `lsblk -d` command.
hard_disk=""  

# Choose a hard disk eraser.
# You can choose "dd" or "shred".
hd_eraser="dd"   

## --- Erase Hard Disk ---
if [ $hd_eraser = "dd" ]; then
    dd if=/dev/zero of=$hard_disk status=progress
elif [ $hd_eraser = "shred" ]; then
    shred -v $hard_disk
fi


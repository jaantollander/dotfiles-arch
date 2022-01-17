#!/bin/bash

# Choose a hard disk to erase.
# You can list your hard disks using `lsblk -d` command.
hard_disk=$1  

# Choose a hard disk eraser.
# You can choose "zeros" or "random". 
hd_eraser=$2   

## --- Erase Hard Disk ---
if [ $hd_eraser = "zeros" ]; then
    dd if=/dev/zero of=$hard_disk status=progress
elif [ $hd_eraser = "random" ]; then
    dd if=/dev/urandom of=$hard_disk status=progress
fi


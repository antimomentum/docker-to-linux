#!/bin/bash

# Run update-grub from the raw disk first, in Rescue mode copy from raw /dev/sda1 to the ext4 /dev/sdX disk
# Run this script once without any extra disks, not even swap!
UUID=$(blkid | awk '{print $2}' | sed 's/UUID="//; s/"//')
sed -i -e "s|\--fs-uuid --set=root $UUID|\--set=root /dev/sda|g" /boot/grub/grub.cfg
sed -i -e "s|root=UUID=$UUID|root=/dev/sda|g" /boot/grub/grub.cfg
wait
update-grub
wait
echo "For the Configuration use GRUB2"

#!/bin/bash

# This script assumes the img has been copied to an ext4 disk and using the grub file supplied with Linode Lish settings
UUID=$(blkid | awk '{print $2}' | sed 's/UUID="//; s/"//')
sed -i -e "s|\--fs-uuid --set=root $UUID|\--set=root /dev/sda|g" /boot/grub/grub.cfg
sed -i -e "s|root=UUID=$UUID|root=/dev/sda|g" /boot/grub/grub.cfg
wait
update-grub
wait
echo "For the Configuration use GRUB2"

## Anti's additions:

The Ubuntu and Debian images are now made for Linode compatibility (also works in WSL2 and anything else that might support GRUB2). The files I've included to this are based on Linode documentation which I'll link below a summary of the instructions.

    make ubuntu18
    gzip ubuntu.img

Then upload the image to Linode either through the browser or cli. 

Once the image is done uploading and being processed deploy the image to a Linode. Boot from Direct Disk. From the Lish console go to Glish and login as root with password root. Then:


    passwd


This may be needed, but isn't always:

    mount -o remount,rw /

This will make the filesystem writeable and allow you to change to a more secure password before the image is brought online, which happens later.

    update-grub


Then Power Down the Linode. At the linode's Storage section Add an ext4 disk. Obviously it should be greater than the size of the image (about 1GB). There's no reason not to add more room to it if need at this point.

Boot into Rescue mode with the image as /dev/sda and the bigger ext4 install disk as /dev/sdb. No other disks are needed for Rescue mode.

Once in Rescue mode do:

    lsblk


To make sure the 1GB image is /dev/sda1 and the install disk is /dev/sdb, if not just change the following command accordingly:

    dd if=/dev/sda1 of=/dev/sdb bs=1M

sda1 is the image you uploaded getting installed to sdb, that's what is happening. Once it's done Power down the Linode.

Change the boot configuration one last time to boot using GRUB 2 from the ext4 install disk set to /dev/sda

Boot the Linode. At this point Weblish should be available and you can login with weblish, and copy paste to/from weblish in firefox.

Running

    df -h

will show the disk size is still only 1GB. To get the full size of your install disk:

    resize2fs /dev/sda

Finally to get the Linode online there is a script at /enable.sh from the image. It requires 3 things:


PUB is the public ip for the linode server

GWAY is the gateway ip for the linode

NEWFACE is the public interface name on the linode itself, usually eth0 or enp0s4. To check names do:

    ip a

change the nameserver ip if needed.


With all 3 in ./enable you can run it and networking should work, try apt update



## Rootless Docker


Once booted you may need to re-install uidmap and re-chown the testuser's home directory for testuser. This may be due to how Docker handles permissions during image building.


    apt purge uidmap
    apt install uidmap
    chown -R testuser: /home/testuser



## References



Linode docs:


https://www.linode.com/docs/guides/install-a-custom-distribution-on-a-linode/#linode-manager-compatibility



https://www.linode.com/docs/products/tools/images/guides/upload-an-image/#requirements-and-considerations


Rootless Docker:


https://docs.docker.com/engine/security/rootless/



Original creator documentation can be found here:


https://github.com/iximiuz/docker-to-linux/blob/master/README.md

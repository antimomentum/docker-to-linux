# docker-to-linux - make bootable Linux disk image abusing Docker

There is no real goal behind this project. Just out of my curiosity what if:

  - launch a base Linux container (debian, alpine, etc)
  - pull in Linux kernel & init system (systemd, OpenRC, etc)
  - dump container's filesystem to a disk image
  - install bootloader (syslinux) to this image...

Then it should be probably possible to launch a ~~real~~ virtual machine with such an image!

Try it out:

```bash
# 1. Build the image.
#    Depending on your setup, you may need to preceed `make` with `sudo`.
make debian  # or ubuntu, or alpine

# 2. Run it! Use username `root` and password `root` to log in.
qemu-system-x86_64 -drive file=debian.img,index=0,media=disk,format=raw -m 4096
# 2. Alternate
qemu-system-x86_64 -hda debian.qcow2 -m 512

# 3. Clean up when you are done.
make clean
```

It works!

Check out `Makefile` for more details or read my article on <a href="https://iximiuz.com/en/posts/from-docker-container-to-bootable-linux-disk-image/">iximiuz.com</a>.

## Features
- Real quick build a bootable Linux image with a single command!
- 3 target distributives: Ubuntu 20.04, Debian Bullseye, Alpine 3.13.5
- Build from macOS (including M1 chips) or Linux hosts

## FAQ
- Q: I'm getting an error about "read-only filesystem". How can I make it writable?

  A: It's Linux default behaviour to mount the / filesystem as read-only. You can always remount it with `mount -o remount,rw /`.

- Q: How can I access network from the VM / How can I SSH into the VM?

  A: Networking is not configured at the moment. If you want to configure it yourself, search for TUN/TAP/bridge devices. Don't forget to open a PR if you come up with a working solution.


## Release notes
#### 2021-05-24
- Start using ext4 instead of ext3.

#### 2021-05-07
- Fix - Ubuntu 20.04 stopped working because of the changed path to vmlinuz and initrd files.

#### 2021-05-02
- Fix macOS support [#10](https://github.com/iximiuz/docker-to-linux/issues/10) (thanks to @xavigonzalvo for reporting and suggesting the fix)
  - move `losetup` call from Makefile to the builder container
  - explicitly select amd64 architecture in target distr Dockerfiles to support builds on ARM hosts (_aka_ M1)
- Upgrade target distr versions
  - Ubuntu 18.04 -> 20.04
  - Debian Stretch -> Bullseye
  - Alpine 3.9.4 -> 3.13.5

#### 2020-02-29
- Improve Alpine support [#7](https://github.com/iximiuz/docker-to-linux/pull/7) (creds @monperrus)

#### 2019-08-02
- Fix loopback device lookup [#3](https://github.com/iximiuz/docker-to-linux/pull/3) (creds @christau)

#### 2019-06-03
- Initial release

## TODO
- add basic networking support
- make filesystem writable after boot
- support different image formats (e.g. VirtualBox VDI)
- support different target architectures (e.g. ARM)

## Anti's additions:

The Ubuntu image is now made for Linode compatibility. The files I've included to this are based on Linode documentation which I'll link below a summary of the instructions.

    make ubuntu
    gzip ubuntu.img

Then upload the image to Linode either through the browser or cli. 

Once the image is done uploading and being processed deploy the image to a Linode. Boot from Direct Disk. From the Lish console go to Glish and login as root with password root. Then:


    mount -o remount,rw /
    password

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


Linode docs:


https://www.linode.com/docs/guides/install-a-custom-distribution-on-a-linode/#linode-manager-compatibility



https://www.linode.com/docs/products/tools/images/guides/upload-an-image/#requirements-and-considerations

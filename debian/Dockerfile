FROM amd64/debian
LABEL com.iximiuz-project="docker-to-linux"
RUN apt-get -y update
RUN apt-get -y install --no-install-recommends \
  linux-image-amd64 \
  systemd-sysv \
  iproute2 \
  nano \
  grub2 \
  e2fsprogs
RUN echo "root:root" | chpasswd
COPY debian/fstab /etc/fstab
COPY debian/grub.cfg /boot/grub/grub.cfg
COPY debian/grub /etc/default/grub
COPY debian/enable.sh enable.sh
COPY grub2-lish.sh grub2-lish.sh
RUN chmod +x enable.sh


FROM amd64/ubuntu:20.04
LABEL com.iximiuz-project="docker-to-linux"
RUN apt-get update -y && \
  apt-get -y install \
  nano \
  linux-image-virtual \
  systemd-sysv \
  iproute2
RUN echo "root:root" | chpasswd
COPY ubuntu/fstab /etc/fstab
COPY ubuntu/grub.cfg /boot/grub/grub.cfg
COPY ubuntu/grub /etc/default/grub
COPY ubuntu/enable.sh enable.sh
RUN chmod +x enable.sh

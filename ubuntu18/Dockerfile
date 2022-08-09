
FROM amd64/ubuntu:20.04
LABEL com.iximiuz-project="docker-to-linux"
RUN apt-get update -y && \
  apt-get -y install \
  nano \
  linux-image-virtual \
  systemd-sysv \
  iproute2
RUN echo "root:root" | chpasswd
COPY ubuntu18/fstab /etc/fstab
COPY ubuntu18/grub.cfg /boot/grub/grub.cfg
COPY ubuntu18/grub /etc/default/grub
COPY ubuntu18/enable.sh enable.sh
RUN chmod +x enable.sh

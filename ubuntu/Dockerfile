FROM amd64/ubuntu:20.04
LABEL com.iximiuz-project="docker-to-linux"
RUN apt-get update -y
RUN apt-get -y install \
  linux-image-virtual \
  systemd-sysv \
  iproute2 \
  nano
RUN echo "root:root" | chpasswd
COPY ./fstab /etc/fstab
COPY ./grub.cfg /boot/grub/grub.cfg
COPY ./grub /etc/default/grub
COPY ./enable.sh /enable.sh
RUN update-grub && chmod +x enable.sh

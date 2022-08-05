FROM amd64/ubuntu:20.04
LABEL com.iximiuz-project="docker-to-linux"
RUN apt-get update -y
RUN apt-get -y install \
  linux-image-virtual \
  systemd-sysv \
  iproute2
RUN echo "root:root" | chpasswd


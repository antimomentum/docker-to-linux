FROM amd64/ubuntu:20.04
LABEL com.iximiuz-project="docker-to-linux"
RUN apt-get update -y && \
  apt-get -y install \
  iptables \
  bash \
  sudo \
  curl \
  nano \
  linux-image-virtual \
  systemd-sysv \
  iproute2 \
  uidmap \
  dbus-user-session

RUN echo "root:root" | chpasswd
COPY ubuntu20/fstab /etc/fstab
COPY ubuntu20/grub.cfg /boot/grub/grub.cfg
COPY ubuntu20/grub /etc/default/grub
COPY ubuntu20/enable.sh enable.sh
RUN chmod +x enable.sh
RUN useradd -m testuser
RUN usermod --shell /bin/bash testuser
RUN chown -R testuser: /home/testuser

RUN sudo -H -u testuser bash -c 'curl -fsSL https://get.docker.com/rootless | sh'
RUN sudo -i -u testuser sh -c 'echo "export XDG_RUNTIME_DIR=/home/testuser/.docker/run" >> .bashrc'
RUN sudo -i -u testuser sh -c 'echo "export PATH=/home/testuser/bin:$PATH" >> .bashrc'
RUN sudo -i -u testuser sh -c 'echo "export DOCKER_HOST=unix:///home/testuser/.docker/run/docker.sock" >> .bashrc'

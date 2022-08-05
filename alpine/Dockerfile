FROM amd64/alpine:3.13.5
LABEL com.iximiuz-project="docker-to-linux"
RUN apk update
RUN apk add openrc linux-virt iproute2
RUN echo "root:root" | chpasswd


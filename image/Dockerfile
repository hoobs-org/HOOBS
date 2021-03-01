ARG BASE_IMAGE=debian:buster
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
        git vim parted \
        quilt coreutils qemu-user-static debootstrap zerofree zip dosfstools \
        bsdtar libcap2-bin rsync grep udev xz-utils curl xxd file kmod bc\
        binfmt-support ca-certificates gcc-aarch64-linux-gnu \
    && rm -rf /var/lib/apt/lists/*

COPY . /hoobs-image/

VOLUME [ "/hoobs-image/work", "/hoobs-image/deploy"]

#!/bin/bash -e

install -m 644 files/hoobs "${ROOTFS_DIR}/etc/"

on_chroot << EOF
    uname -a
    set -e
    set -x

    systemctl enable avahi-daemon.service
    npm install -g --unsafe-perm yarn
EOF

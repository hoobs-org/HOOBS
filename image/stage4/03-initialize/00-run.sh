#!/bin/bash -e 

install -m 644 "files/hoobs-cli.tar.gz" "${ROOTFS_DIR}/hoobs-cli.tar.gz"
install -m 644 "files/hoobsd.tar.gz" "${ROOTFS_DIR}/hoobsd.tar.gz"
install -m 644 "files/hoobs-gui.tar.gz" "${ROOTFS_DIR}/hoobs-gui.tar.gz"

on_chroot << EOF
    uname -a
    set -e
    set -x
    sudo hbs install -p 80
EOF
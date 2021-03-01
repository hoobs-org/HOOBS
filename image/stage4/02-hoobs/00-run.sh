#!/bin/bash -e 

install -m 644 "files/hoobs-cli.tar.gz" "${ROOTFS_DIR}/hoobs-cli.tar.gz"
install -m 644 "files/hoobsd.tar.gz" "${ROOTFS_DIR}/hoobsd.tar.gz"
install -m 644 "files/hoobs-gui.tar.gz" "${ROOTFS_DIR}/hoobs-gui.tar.gz"

on_chroot << EOF
    uname -a
    set -e
    set -x
    tar -xzf /hoobs-cli.tar.gz -C /usr --strip-components=1 --no-same-owner
    tar -xzf /hoobsd.tar.gz -C /usr --strip-components=1 --no-same-owner
    tar -xzf /hoobs-gui.tar.gz -C /usr --strip-components=1 --no-same-owner
    rm -rf /hoobs-cli.tar.gz
    rm -rf /hoobsd.tar.gz
    rm -rf /hoobs-gui.tar.gz
EOF
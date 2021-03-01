#!/bin/bash -e

install -m 644 files/tzupdate.service "${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << EOF
    update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
    update-alternatives --install /usr/bin/python python /usr/bin/python3.7 2

    pip3 install -U tzupdate

    systemctl daemon-reload
    systemctl enable tzupdate
EOF

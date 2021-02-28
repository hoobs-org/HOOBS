#!/bin/bash -e

on_chroot << EOF
	wget https://deb.nodesource.com/setup_lts.x
    chmod 755 ./setup_lts.x
    ./setup_lts.x
    rm -f ./setup_lts.x
    apt-get update
EOF

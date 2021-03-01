#!/bin/bash -e 

on_chroot << EOF
    uname -a
    set -e
    set -x

    sudo hbs system reset
    sudo hbs install -p 80
EOF
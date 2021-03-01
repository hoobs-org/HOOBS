#!/bin/bash -e 

on_chroot << EOF
    uname -a
    set -e
    set -x
    npm install -g yarn
EOF

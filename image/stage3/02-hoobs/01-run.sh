#!/bin/bash -e 

##################################################################################################
# hoobs-image                                                                                    #
# rpi-gen                                                                                        #
# Copyright (C) 2015 Raspberry Pi (Trading) Ltd.                                                 #
#                                                                                                #
# This program is free software: you can redistribute it and/or modify                           #
# it under the terms of the GNU General Public License as published by                           #
# the Free Software Foundation, either version 3 of the License, or                              #
# (at your option) any later version.                                                            #
#                                                                                                #
# This program is distributed in the hope that it will be useful,                                #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                                 #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                                  #
# GNU General Public License for more details.                                                   #
#                                                                                                #
# You should have received a copy of the GNU General Public License                              #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.                          #
##################################################################################################

mkdir -p "${ROOTFS_DIR}/var/lib/hoobs/"

install -m 644 files/hoobsd.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/bridges.conf "${ROOTFS_DIR}/var/lib/hoobs/"
install -m 644 "files/.bashrc" "${ROOTFS_DIR}/root/"

on_chroot << EOF
    uname -a
    set -e
    set -x

    systemctl daemon-reload
    systemctl enable hoobsd
EOF

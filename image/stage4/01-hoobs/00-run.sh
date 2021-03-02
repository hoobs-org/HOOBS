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

install -m 644 files/hoobsd.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/bridges.conf "${ROOTFS_DIR}/var/lib/hoobs/"
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

    cd /usr/lib/hbs
    yarn install

    cd /usr/lib/hoobsd
    yarn install

    rm -rf /hoobs-cli.tar.gz
    rm -rf /hoobsd.tar.gz
    rm -rf /hoobs-gui.tar.gz

    systemctl daemon-reload
    systemctl enable hoobsd
EOF
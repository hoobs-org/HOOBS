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

install -m 644 files/issue "${ROOTFS_DIR}/etc/issue"
install -m 644 files/motd "${ROOTFS_DIR}/etc/update-motd.d/20-hoobs"
install -m 644 files/wifi-connect.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/wifi-connect-startup "${ROOTFS_DIR}/usr/local/sbin/"
install -m 644 files/raspbian-install.sh "${ROOTFS_DIR}/"
install -m 644 files/hoobs-connect.tar.gz "${ROOTFS_DIR}/"

on_chroot << EOF
    set -x 

    chmod u+x /raspbian-install.sh
    /raspbian-install.sh -y
    rm -rf /raspbian-install.sh

    chmod +x /usr/local/sbin/wifi-connect-startup
    chmod +x /etc/update-motd.d/20-hoobs

    systemctl daemon-reload
    systemctl enable wifi-connect
    systemctl enable NetworkManager
    systemctl disable dhcpcd
EOF

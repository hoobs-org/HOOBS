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

echo "${TIMEZONE_DEFAULT}" > "${ROOTFS_DIR}/etc/timezone"
rm "${ROOTFS_DIR}/etc/localtime"

install -m 644 files/tzupdate.service "${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << EOF
    dpkg-reconfigure -f noninteractive tzdata

    update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
    update-alternatives --install /usr/bin/python python /usr/bin/python3.9 2

    pip3 install -U tzupdate

    systemctl daemon-reload
    systemctl enable tzupdate
EOF

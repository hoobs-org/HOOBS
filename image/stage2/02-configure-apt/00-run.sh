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

install -m 644 files/nodesource.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
install -m 644 files/yarn.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
install -m 644 files/hoobs.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"

sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list.d/nodesource.list"
sed -i "s/NODE/${NODE_RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list.d/nodesource.list"
sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list.d/hoobs.list"

on_chroot apt-key add - < files/nodesource.gpg.key
on_chroot apt-key add - < files/yarn.gpg.key
on_chroot apt-key add - < files/hoobs.gpg.key

on_chroot << EOF
    apt-get update --allow-releaseinfo-change
EOF

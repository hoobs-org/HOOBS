#!/bin/bash -e

##################################################################################################
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

if [ ! -x "${ROOTFS_DIR}/usr/bin/qemu-arm-static" ]; then
	cp /usr/bin/qemu-arm-static "${ROOTFS_DIR}/usr/bin/"
fi

if [ -e "${ROOTFS_DIR}/etc/ld.so.preload" ]; then
	mv "${ROOTFS_DIR}/etc/ld.so.preload" "${ROOTFS_DIR}/etc/ld.so.preload.disabled"
fi

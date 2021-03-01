#!/bin/bash -e 

##################################################################################################
# hoobs-build                                                                                    #
# Copyright (C) 2019 HOOBS                                                                       #
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

install -m 644 "files/hoobs-cli.tar.gz" "${ROOTFS_DIR}/hoobs-cli.tar.gz"
install -m 644 "files/hoobsd.tar.gz" "${ROOTFS_DIR}/hoobsd.tar.gz"
install -m 644 "files/hoobs-gui.tar.gz" "${ROOTFS_DIR}/hoobs-gui.tar.gz"

on_chroot << EOF
    uname -a
    set -e
    set -x
    sudo hbs install -p 80
EOF
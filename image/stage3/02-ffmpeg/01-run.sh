#!/bin/bash -e

##################################################################################################
# hoobs-image                                                                                    #
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

install -m 644 files/ffmpeg.tar.gz "${ROOTFS_DIR}/"

on_chroot << EOF
uname -a

set -e
set -x

tar -xzf /ffmpeg.tar.gz -C /usr/local --strip-components=1 --no-same-owner
rm -rf /ffmpeg.tar.gz

ldconfig -n /usr/local/lib
ldconfig

ffmpeg -version
EOF
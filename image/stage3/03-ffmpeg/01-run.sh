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

on_chroot << EOF
    uname -a
    set -e
    set -x

    wget -O ffmpeg.tar.gz https://github.com/hoobs-org/hoobsd/releases/download/v4.0.69/ffmpeg-v4.3.0.tar.gz
    tar -xzf ./ffmpeg.tar.gz -C /usr/local --strip-components=1 --no-same-owner
    rm -f ./ffmpeg.tar.gz
    ldconfig -n /usr/local/lib
    ldconfig
EOF
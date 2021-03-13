##################################################################################################
# desktop-for-hoobs                                                                              #
# Copyright (C) 2020 HOOBS                                                                       #
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


#!/bin/bash
echo " "
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "This installs an Raspbian Desktop for HOOBS 3.2 or higher"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "After the installation and you can access the Desktop as following:"
echo "----------------------------------------------------------------"
echo "Main Desktop is reachable via HDMI Port"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Start Installation"
echo "----------------------------------------------------------------"
sudo apt-get install raspberrypi-ui-mods  -y
echo "----------------------------------------------------------------"
echo "Installation Successfull"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "Main Desktop is reachable via HDMI Port after a reboot"
echo "----------------------------------------------------------------"
echo "Rebooting now..."
sudo reboot

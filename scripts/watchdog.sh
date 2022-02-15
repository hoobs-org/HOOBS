#!/bin/bash

# DO NOT USE THIS SCRIPT - ITS IN TESTING STATE AND MAY CORRUPT YOUR HOOBS DEVICE


# HOW TO RUN THE SCRIPT

# wget -q -O - https://raw.githubusercontent.com/hoobs-org/HOOBS/main/scripts/watchdog.sh | sudo bash -



##################################################################################################
# hoobs-watchdog                                                                           #
# Copyright (C) 2022 HOOBS                                                                       #
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
# Author: Bobby Slope     
echo " "
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "This script will Setup Watchdog for HOOBS"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "This will automatically soft reboot your system if it got stuck"
echo "----------------------------------------------------------------"
echo "This Watchdog will prevent the need of reflash"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "Setup Watchdog...."
sudo apt-get update --yes
sudo apt-get install watchdog --yes
sudo update-rc.d watchdog defaults
cat > /etc/watchdog.conf <<EOL
watchdog-device = /dev/watchdog
watchdog-timeout = 15
max-load-1 = 24
min-memory = 1
EOL
echo "----------------------------------------------------------------"
echo "Watchdog installed"
echo "----------------------------------------------------------------"
echo "Setting up Service....."
sudo systemctl daemon-reload
sudo systemctl enable watchdog
echo "----------------------------------------------------------------"
echo "Service created."
echo "----------------------------------------------------------------"
echo "Starting Starting"
sudo systemctl start watchdog
echo "----------------------------------------------------------------"
echo "use journalctl -u watchdog.service to display the log"
echo "----------------------------------------------------------------"
echo "use :(){ :|:& };: to crash the system on purpose"
echo "----------------------------------------------------------------"
echo "Getting Status Status close with ctrl+c"
echo "----------------------------------------------------------------"
journalctl -u watchdog.service





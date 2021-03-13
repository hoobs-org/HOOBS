#!/bin/bash

##################################################################################################
# hoobs-pihole                                                                      #
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

echo " "
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "This script will install Pi-Hole for HOOBS 3"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "After the installation is completed you can access Pi-Hole:"
echo "----------------------------------------------------------------"
echo "Pi-Hole Interface is reachable at hoobs.local:1882"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Updating SSL Certificates and Rights"
sudo wget -O /etc/ssl/certs/cacert.pem https://curl.haxx.se/ca/cacert.pem
rm -rf /etc/profile
wget -P /etc/ https://raw.githubusercontent.com/hoobs-org/HOOBS/main/scripts/profile
rm -rf /etc/sudoers
wget -P /etc/ https://raw.githubusercontent.com/hoobs-org/HOOBS/main/scripts/sudoers
echo "SSL Certificates and Rights updated"
echo "----------------------------------------------------------------"
echo "Installing Pi-Hole"
sudo curl -L https://install.pi-hole.net | bash /dev/stdin --unattended
echo "Pi-Hole installed"
echo "----------------------------------------------------------------"
echo "Change Pi-Hole Port to 1882"
sudo cp /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf.backup
sudo sed -ie 's/= 80/= 1882/g' /etc/lighttpd/lighttpd.conf
echo "Give www-data access to edit pi-hole settings"
echo 'www-data ALL = NOPASSWD : ALL' | sudo tee -a /etc/sudoers
sudo /etc/init.d/lighttpd restart
echo "----------------------------------------------------------------"
echo "Changed Pi-Hole Port to 1882"
echo "----------------------------------------------------------------"
echo "Change Pi-Hole Admin to default Password"
pihole -a -p hoobsadmin
echo "----------------------------------------------------------------"
echo "Changed Pi-Hole Admin to default Password"
echo "----------------------------------------------------------------"
echo "Pi-Hole is now reachable at hoobs.local:1882/admin"
echo "Pi-Hole password is: hoobsadmin"
echo "----------------------------------------------------------------"
echo "Rebooting Now"
sudo reboot

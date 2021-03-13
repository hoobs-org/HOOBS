#!/bin/bash

echo " "
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "This will install Unifi Controller for HOOBS 3"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "After the installation is completed the Device performs an"
echo "reboot and you can access UniFi  Conntroller  and HOOBS as following:"
echo "----------------------------------------------------------------"
echo "Unifi   Interface is reachable at hoobs.local:8443"
echo "HOOBS   Interface is reachable at hoobs.local"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Beginn Installation...."
echo "----------------------------------------------------------------"
sudo apt-get install openjdk-8-jre-headless -y
echo 'deb http://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ubnt.com/unifi/unifi-repo.gpg
sudo apt-get clean
sudo apt-get update; sudo apt-get install unifi -y
rm -rf /lib/systemd/system/unifi.service
wget -P /lib/systemd/system https://raw.githubusercontent.com/hoobs-org/HOOBS/main/scripts/unifi.service
sudo systemctl stop mongodb 
sudo systemctl disable mongodb
sudo systemctl enable unifi.service
sudo systemctl start unifi.service
sudo systemctl daemon-reload
echo "----------------------------------------------------------------"
echo "After the installation is completed the Device performs an"
echo "reboot and you can access Unifi Controller and HOOBS as following:"
echo "----------------------------------------------------------------"
echo "Unifi   Interface is reachable at hoobs.local:8443"
echo "HOOBS   Interface is reachable at hoobs.local"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "Rebooting now in 10 Seconds.........."
echo "----------------------------------------------------------------"
sudo reboot
echo "----------------------------------------------------------------"
echo "Enter now URL: hoobs.local:8443 to get to the Unifi Controller"
echo "----------------------------------------------------------------"

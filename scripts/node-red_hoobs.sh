#!/bin/bash

echo "----------------------------------------------------------------"
echo "This will install Node-RED for HOOBS 3"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "Installing Node-RED core....."
mkdir /home/hoobs/.node-red
cd /home/hoobs/.node-red
sudo npm install -g --silent --unsafe-perm --force node-red
echo "Node-RED core installed."
echo "----------------------------------------------------------------"
echo "Installing Raspberry-Pi Nodes....."
sudo npm install -g --silent --unsafe-perm --save node-red-contrib-homebridge-automation node-red-node-pi-gpio node-red-node-random node-red-node-ping node-red-contrib-play-audio node-red-node-smooth node-red-node-serialport
echo "Raspberry-Pi Nodes installed"
echo "----------------------------------------------------------------"
echo "Setup Auto Start Service....."
cat > /etc/systemd/system/nodered_boot.service <<EOL
# systemd service file to start Node-RED

[Unit]
Description=Node-RED graphical event wiring tool
Wants=network.target
Documentation=http://nodered.org/docs/hardware/raspberrypi.html

[Service]
Type=simple
User=root
WorkingDirectory=/home/hoobs
Nice=5
Environment="NODE_OPTIONS=--max_old_space_size=256"
ExecStart=/usr/local/bin/node-red-pi $NODE_OPTIONS $NODE_RED_OPTIONS
KillSignal=SIGINT
Restart=on-failure
SyslogIdentifier=Node-RED

[Install]
WantedBy=multi-user.target
EOL
cd /usr/local/bin
sudo ln -s /home/hoobs/.node-red/node_modules/.bin/node-red-pi node-red-pi
sudo systemctl daemon-reload
sudo systemctl enable nodered_boot.service
sudo systemctl restart nodered_boot.service
echo "Node-RED successfully installed"
echo "----------------------------------------------------------------"
echo "Node-RED Interface is reachable at hoobs.local:1880"
echo "HOOBS    Interface is reachable at hoobs.local"
echo "----------------------------------------------------------------"

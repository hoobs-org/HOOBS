#!/bin/bash

sudo npm install -g --unsafe-perm node-red

cat > /etc/systemd/system/node-red.service <<EOL
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
ExecStart=/usr/bin/node-red-pi
KillSignal=SIGINT
Restart=on-failure
SyslogIdentifier=Node-RED

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl enable node-red.service
sudo systemctl restart node-red.service

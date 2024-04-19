#!/bin/sh
set -x
apt-get update &&
apt-get install x11vnc-service -y &&

echo "[Unit]
Description=X11VNC Server
After=prefdm.service

[Service]
User=root
Restart=on-failure
ExecStart=/usr/bin/x11vnc -auth /var/run/lightdm/root/:0 -dontdisconnect -notruecolor -noxfixes -shared -forever -rfbport 5900 -oa /var/log/x11vnc.log -rfbauth /root/.vnc/passwd

[Install]
WantedBy=graphical.target" > /lib/systemd/system/x11vnc.service &&

systemctl daemon-reload && 
chkconfig x11vnc on &&
service x11vnc start &&
x11vnc --storepasswd






#!/bin/sh
set -x
apt-get update && 
apt-get install sudo -y &&
sed -i 101i\ 'WHEEL_USERS ALL=(ALL) NOPASSWD: ALL' /etc/sudoers &&
sed -i 12i\ 'Port 22' /etc/openssh/sshd_config &&
sed -i 41i\ 'domain-name=noname.local' /etc/avahi/avahi-daemon.conf &&
#
sudo control su public &&
#
systemctl start sshd.service &&
systemctl enable sshd.service &&
dconf write /org/gnome/desktop/screensaver/lock-enabled false &&
#
apt-get install pinta fonts-ttf-ms eepm update-kernel yandex-browser-stable -y &&
apt-get dist-upgrade -y &&
#
epm ei &&
epm play chrome onlyoffice -y &&
#
update-kernel -y &&
#
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




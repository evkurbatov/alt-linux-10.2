#!/bin/sh
set -x
echo "enter-username = true" >> /etc/lightdm/lightdm-gtk-greeter.conf &&
roleadd users cdwriter cdrom audio proc radio camera floppy xgrp scanner uucp fuse dialout usershares video proc radio camera floppy xgrp vboxusers fuse vboxadd printadmin &&
roleadd localadmins wheel remote vboxusers &&
roleadd 'Пользователи домена' users &&
roleadd 'Администраторы домена' localadmins &&
sed -i 's/SystemGroup sys wheel root/SystemGroup printadmin sys wheel root/' /etc/cups/cups-files.conf &&
echo "SetEnv GS_OPTIONS -dNoOutputFonts" >> /etc/cups/cups-files.conf &&
systemctl restart cups

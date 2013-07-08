# this is all post partitioning and initial install

# to activate, use: ./bowser.sh

pacman -S xorg-server xorg-server-utils xorg-xinit
pacman -S mesa
pacman -S xf86-video-vesa xf86-video-intel
pacman -S xorg-twm xorg-xclock xterm
pacman -S alsa-utils

rm ~/.xinitrc

pacman -S openbox chromium openssh rsync flashplayer

useradd -m guest

echo "[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx" >> ~/.zprofile

cp /etc/skel/.bash_profile ~/.bashprofile
echo "[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx" >> ~/.bash_profile

mkdir /etc/systemd/system/getty@tty1.service.d
touch /etc/systemd/system/getty@tty1.service.d/autologin.conf

echo ":i" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "[Service]" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "ExecStart=-usr/bin/agetty --autologin guest --noclear % 38400 linux" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "Type=simple" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf

systemctl enable graphical.target

cp -r /home/guest /opt/
cd /opt/guest
chmod -R a+r /opt/guest

touch .xinitrc

echo ":i" >> .xinitrc
echo "xset s off" >> .xinitrc
echo "xset -dpms" >> .xinitrc
echo "openbox-session &" >> .xinitrc
echo "while true; do" >> .xinitrc
echo "  rsync -qr --delete --exclude='.Xauthority' /opt/guest/ $HOME/" >> .xinitrc
echo "  chromium http: //www.google.com/" >> .xinitrc
echo "done" >> .xinitrc

rm /etc/xdg/openbox/menu.xml
touch /etc/xdg/openbox/menu.xml

echo "<openbox_menu>" >> /etc/xdg/openbox/menu.xml
echo '<menu id="root-menu" label="Openbox 3">' >> /etc/xdg/openbox/menu.xml
echo '  <seperator label="Operation Not Supported" />' >> /etc/xdg/openbox/menu.xml
echo "</menu>" >> /etc/xdg/openbox/menu.xml
echo "</openbox_menu>" >> /etc/xdg/openbox/menu.xml

rm /etc/xdg/openbox/rc.xml
cp /home/bowser/rc.xml /etc/xdg/openbox/rc.xml

reboot

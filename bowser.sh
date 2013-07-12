# this is all post partitioning, initial install, and reboot

pacman -S xorg-server xorg-server-utils xorg-xinit
pacman -S mesa
pacman -S xf86-video-vesa
pacman -S xf86-video-intel
pacman -S xorg-twm xorg-xclock xterm

pacman -S openbox chromium openssh rsync

pacman -S flashplayer

echo pacman operations complete
sleep 2s

useradd -m guest
echo guest user added...
sleep 2s

mkdir /etc/systemd/system/getty@tty1.service.d/
touch /etc/systemd/system/getty@tty1.service.d/autologin.conf

echo '[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin guest --noclear %I 38400 linux
Type=simple' > /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo autologin.conf configured...
sleep 2s

systemctl enable graphical.target

echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> /home/guest/.bash_profile
echo bash profile configured...
sleep 2s

cp -r /home/guest /opt/
cd /opt/guest/
chmod -R a+r . 

cp /home/bowser/.xinitrc /opt/guest/
chmod a+x .xinitrc
cp .xinitrc /home/guest/
echo xinitrc configured...
sleep 2s

rm /etc/xdg/openbox/menu.xml
touch /etc/xdg/openbox/menu.xml
echo '<openbox_menu>
<menu id="root-menu" label="Openbox 3">
  <separator label="Operation Not Supported" />
</menu>
</openbox_menu>' >> /etc/xdg/openbox/menu.xml
echo openbox root-menu configured...
sleep 2s

rm /etc/xdg/openbox/rc.xml
cp /home/bowser/rc.xml /etc/xdg/openbox/rc.xml
echo chromium maximized...
sleep 2s

echo rebooting...
sleep 2s
reboot

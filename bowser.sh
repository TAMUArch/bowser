# this is all post partitioning, initial install, and reboot

pacman -S --noconfirm xorg-server xorg-server-utils xorg-xinit
pacman -S --noconfirm mesa
pacman -S --noconfirm xf86-video-vesa
pacman -S --noconfirm xf86-video-intel
pacman -S --noconfirm xorg-twm xorg-xclock xterm

pacman -S --noconfirm openbox chromium openssh rsync

pacman -S --noconfirm flashplayer feh

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

cp /home/bowser/.fehbg /home/guest/
rm /etc/xdg/openbox/rc.xml
cp /home/bowser/rc.xml /etc/xdg/openbox/rc.xml
echo desktop and chromium configured...
sleep 2s

amixer sset Master unmute, playback 31db
echo sound configured...
sleep 2s

echo rebooting...
sleep 2s
reboot

# this is all post partitioning, initial install, and reboot

pacman -S xorg-server xorg-server-utils xorg-xinit
pacman -S mesa
pacman -S xf86-video-vesa
pacman -S xf86-video-intel
pacman -S xorg-twm xorg-xclock xterm

pacman -S openbox chromium openssh rsync

useradd -m guest

cp /etc/skel/.bash_profile ~/.bash_profile
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> ~/.bash_profile
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> ~/.zprofile

mkdir /etc/systemd/system/getty@tty1.service.d/
touch /etc/systemd/system/getty@tty1.service.d/autologin.conf

echo '[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin guest --noclear %I 38400 linux
Type=simple' > /etc/systemd/system/getty@tty1.service.d/autologin.conf

systemctl enable graphical.target

cp -r /home/guest /opt/
cd /opt/guest/
chmod -R a+r . 

cp /etc/skel.xinitrc /opt/guest/
chmod a+x .xinitrc
echo 'xset s off
xset -dpms
openbox-session &
while true; do
  rsync -qr --delete --exclude='.Xauthority' /opt/guest/ $HOME/
  chromium http://www.google.com/
done' >> .xinitrc

cp .xinitrc /home/guest/

reboot

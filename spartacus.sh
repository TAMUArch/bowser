# this is all post partitioning, initial install, and reboot
# attempting to discover exact path to perfect bowser setup

pacman -S xorg-server xorg-server-utils xorg-xinit #check
pacman -S mesa #check
pacman -S xf86-video-vesa #check 
pacman -S xf86-video-intel #check
pacman -S xorg-twm xorg-xclock xterm #check

#### Doing something different here
#there is no ~/.xinitrc file to remove, contrary to directions
startx #check 
#need to manually exit X to return to script

pacman -S openbox chromium openssh rsync #check

useradd -m guest #check

cp /etc/skel/.bash_profile ~/.bash_profile #check
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> ~/.bash_profile #check

#ok, now i think i've figured it out... there has to be an error is this service.d area
#upon fixing it, autologin for guest is operational!!!
mkdir /etc/systemd/system/getty@tty1.service.d/ #check
touch /etc/systemd/system/getty@tty1.service.d/autologin.conf #check
#was missing a forward slash on /usr
echo '[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin guest --noclear %I 38400 linux
Type=simple' > /etc/systemd/system/getty@tty1.service.d/autologin.conf #check

systemctl enable graphical.target #check

cp -r /home/guest /opt/ #check
cd /opt/guest/ #check
chmod -R a+r . 
#^^check

touch .xinitrc #check
chmod a+x .xinitrc #check
echo 'xset s off
xset -dpms
openbox-session &
while true; do
  rsync -qr --delete --exclude='.Xauthority' /opt/guest/ $HOME/
  chromium http://www.google.com/
done' > .xinitrc #check

cp .xinitrc /home/guest #check

rm /etc/xdg/openbox/menu.xml
touch /etc/xdg/openbox/menu.xml
echo '<openbox_menu>
<menu id="root-menu" label="Openbox 3">
  <seperator label="Operation Not Supported" />
</menu>
</openbox_menu>' >> /etc/xdg/openbox/menu.xml
echo openbox menu edited
sleep 5s

rm /etc/xdg/openbox/rc.xml
cp /home/bowser/rc.xml /etc/xdg/openbox/rc.xml
echo chrome set to maximized
sleep 5s
echo shutting down
sleep 5s
flashplayer alsa-utils
shutdown now

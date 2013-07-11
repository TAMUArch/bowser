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

echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> ~/.zprofile
cp /etc/skel/.bash_profile ~/.bash_profile
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> ~/.bash_profile
echo .zprofile and .bash_profile configured
sleep 5s

mkdir /etc/systemd/system/getty@tty1.service.d
touch /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo getty directory created and autologin.conf created
sleep 5s

echo ':i
[Service]
ExecStart=
ExecStart=-usr/bin/agetty --autologin guest --noclear %I 38400 linux
Type=simple' >> /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo autologin.conf configured
sleep 5s

systemctl enable graphical.target
echo systemctl enable graphical.target
sleep 5s

cp -r /home/guest /opt/
cd /opt/guest/
chmod -R a+r .
echo changed directory to /opt/guest and gave permissions
sleep 5s

touch .xinitrc
chmod a+x .xinitrc
echo ':i
xset s off
xset -dpms
openbox-session &
while true; do
  rsync -qr --delete --exclude='.Xauthority' /opt/guest/ $HOME/
  chromium http://www.google.com/
done' >> .xinitrc
echo .xinitrc created and modified
sleep 5s

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

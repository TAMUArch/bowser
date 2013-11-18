pacman -S --noconfirm xorg-server xorg-server-utils xorg-xinit mesa
pacman -S --noconfirm xf86-video-vesa xf86-video-intel xorg-twm xorg-xclock xterm
pacman -S --noconfirm openbox chromium openssh rsync flashplayer feh alsa-utils git

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
systemctl enable cronie.service
cp config/job /var/spool/cron/root
echo cron job enabled
sleep 2s

echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> /home/guest/.bash_profile
echo bash profile configured...
sleep 2s

cp -r /home/guest /opt/
cd /opt/guest/
chmod -R a+r . 

cp /home/bowser/config/.xinitrc /opt/guest/
chmod a+x .xinitrc
cp .xinitrc /home/guest/
echo xinitrc configured...
sleep 2s

cp /home/bowser/config/.fehbg /home/guest/
rm /etc/xdg/openbox/rc.xml
cp /home/bowser/config/rc.xml /etc/xdg/openbox/rc.xml
echo desktop and chromium configured...
sleep 2s

amixer sset Master unmute, playback 31db
echo sound configured...
sleep 2s

cd /home/bowser/config/
cp grub /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo silent grub boot configured...
sleep 2s

\curl -L https://get.rvm.io | bash -s stable --ruby
source /home/vagrant/.rvm/scripts/rvm
cd ~/
git clone https://github.com/TAMUArch/bowser-webapp.git
cd bowser-webapp
rvm use ruby
rvm gemset create bowser
rvm gemset use bowser
bundle install
./run.sh
echo bowser-webapp installed...
sleep 2s

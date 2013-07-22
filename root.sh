rm /etc/locale.gen
cp /home/bowser/locale.gen /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

ln -s /usr/share/zoneinfo/US/Central /etc/localtime
hwclock --systohc --utc

echo bowser > /etc/hostname
systemctl enable dhcpcd.service

passwd

pacman -S --noconfirm grub
grub-install --recheck /dev/sdb
grub-mkconfig -o /boot/grub/grub.cfg

/home/bowser.sh
exit

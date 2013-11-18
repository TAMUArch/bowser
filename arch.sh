pacman -Syy --noconfirm
pacman -Syu --noconfirm

(echo 'n
p
1

20971520
a
n
p
2


w') | fdisk /dev/sdb

mkfs.ext4 /dev/sdb1
mkfs.ext4 /dev/sdb2

mount /dev/sdb1 /mnt
mkdir /mnt/home
mount /dev/sdb2 /mnt/home

pacstrap /mnt base
genfstab -U -p /mnt >> /mnt/etc/fstab

cp -r /home/bowser /mnt/home

arch-chroot /mnt /home/scripts/bowser/root.sh

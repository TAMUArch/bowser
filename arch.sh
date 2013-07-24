pacman -Syy --noconfirm
pacman -Syu --noconfirm

(echo 'n
p
1


a
w') | fdisk /dev/sdb

mkfs.ext4 /dev/sdb1

mount /dev/sdb1 /mnt
mkdir /mnt/home

pacstrap /mnt base
genfstab -U -p /mnt >> /mnt/etc/fstab

cp -r /home/bowser /mnt/home

arch-chroot /mnt /home/bowser/root.sh

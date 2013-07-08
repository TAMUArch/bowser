pacman -Syy
pacman -Syu

#Partitioning Shit

mkfs.ext4 /dev/sdb1
mkfs.ext4 /dev/sdb2

mount /dev/sdb1 /mnt
mkdir /mnt/home
mount /dev/sdb2 /mnt/home

pacstrap /mnt base

genfstab -U -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt



chmod u+x arch.sh
chmod u+x archroot.sh
chmod u+x bowser.sh

./arch.sh

echo unmounting...
sleep 5s
umount /mnt/home
umount /mnt
echo unmounted
sleep 5s

echo shutting down...
sleep 5s
shutdown now

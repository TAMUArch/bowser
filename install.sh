#Version 1
chmod u+x arch.sh
chmod u+x root.sh
chmod u+x bowser.sh
chmod u+x cronjob.sh

./arch.sh

echo unmounting...
sleep 2s
umount /mnt
echo unmounted
sleep 2s

echo shutting down...
sleep 2s
shutdown now

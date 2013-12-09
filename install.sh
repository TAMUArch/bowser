#Version 1
chmod u+x scripts/arch.sh
chmod u+x scripts/root.sh
chmod u+x scripts/bowser.sh
chmod u+x scripts/cronjob.sh

./scripts/arch.sh

echo unmounting...
sleep 2s
umount /mnt/home
umount /mnt
echo unmounted
sleep 2s

echo shutting down...
sleep 2s
shutdown now

xset s off
xset -dpms
openbox-session &
while true; do
  eval `cat /home/guest/.fehbg`
  rsync -qr --delete --exclude='.Xauthority' /opt/guest/ $HOME/
  chromium --incognito http://www.google.com/
done

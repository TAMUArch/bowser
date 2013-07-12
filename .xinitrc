xset s off
xset -dpms
openbox-session &
while true; do
  rsync -qr --delete --exclude='.Xauthority' /opt/guest/ $HOME/
  chromium http://www.google.com/
done

xset s off
xset -dpms
xinput --set-prop 9 'Device Accel Constant Deceleration' 5 &
openbox-session &
cd /home/guest/bowser-webapp && ./run.sh &
while true; do
  eval `cat /home/guest/.fehbg`
  rsync -qr --delete --exclude='.Xauthority' /opt/guest/ $HOME/
  chromium --incognito http://www.youtube.com/channel/UCIj_oISQvBPGVrgrJWx0TMA/
done

# Should make it run everynight at midnight:
# 0 0 * * * ./home/bowser/cronjob.sh

rm -rf /home/guest/*

echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> /home/guest/.bash_profile

cp -r /home/guest /opt/
cd /opt/guest/
chmod -R a+r . 
cp /home/bowser/config/.xinitrc /opt/guest/
chmod a+x .xinitrc
cp .xinitrc /home/guest/
  
cp /home/bowser/config/.fehbg /home/guest/


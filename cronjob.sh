# Should make it run everynight at midnight:
# 0 0 * * * ./home/bowser/cronjob.sh

rm -r /home/guest/*

echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> /home/guest/.bash_profile

cp -r /home/guest /opt/
cd /opt/guest/
chmod -R a+r . 
cp /home/bowser/.xinitrc /opt/guest/
chmod a+x .xinitrc
cp .xinitrc /home/guest/
  
cp /home/bowser/.fehbg /home/guest/


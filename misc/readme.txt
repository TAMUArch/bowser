To change HOSTNAME:

hostname <input>
echo <input> > /etc/hostname

STATIC IP TIME:

cp /etc/netctl/examples/ethernet-static /etc/network.d/<newprofilename>

Edit the file (vim!) with the appropriate IP, Gateway, and DNS

Disable any other netcfg profiles

systemctl stop netcfg@<otherprofilename>
systemctl disable netcfg@<otherprofilename>

Enable the new profile

systemctl enable netcfg@<newprofile>
systemctl start netcfg@<newprofile>

Reboot

#!/bin/bash

#install
apt update && apt upgrade
apt install python3 python3-pip git
git clone https://github.com/scscp/scupdate.git
unzip scupdate/ftvpn.zip
pip3 install -r ftvpn/requirements.txt
pip3 install pillow

#isi data
echo ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
read -e -p "[*] Input Your Domain :" domain
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/ftvpn/var.txt
echo -e ADMIN='"'$admin'"' >> /root/ftvpn/var.txt
echo -e DOMAIN='"'$domain'"' >> /root/ftvpn/var.txt
clear
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "DOMAIN         : $bottoken"
echo "Email          : $admin"
echo "Api Key        : $domain"
echo -e "==============================="
echo "Setting done"

cat > /etc/systemd/system/ftvpn.service << END
[Unit]
Description=Simple ftvpn - @ftvpn
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/python3 -m ftvpn
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start ftvpn 
systemctl enable ftvpn

clear

echo " Installations complete, type /menu on your bot"

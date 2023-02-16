#!/bin/sh

echo "Create service."
sudo chmod 777 ./rst_nm.sh
if [ ! -f /lib/systemd/system/rst_nm.service ];
then 
    sudo cp ./rst_nm.service /lib/systemd/system/
fi

echo "Enable service."
sudo systemctl enable rst_nm.service

echo "Create wpa_supplicant.conf"
sudo cp ./wpa_supplicant.conf /etc/wpa_supplicant.conf

echo "Setup interface."
sudo chmod 777 /etc/network/interfaces
sudo echo 'auto wlan0' >> /etc/network/interfaces
sudo echo 'iface wlan0 inet dhcp' >> /etc/network/interfaces
sudo echo 'pre-up sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf' >> /etc/network/interfaces
sudo echo 'post-down killall -q wpa_supplicant' >> /etc/network/interfaces
sudo chmod 644 /etc/network/interfaces

echo "Done."
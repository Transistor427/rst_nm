#!/bin/sh

# s

sudo chmod 777 ./rst_nm.sh
sudo cp ./rst_nm.service /lib/systemd/system/
sudo systemctl enable rst_nm.service

sudo cp ./wpa_supplicant.conf /etc/wpa_supplicant.conf

sudo chmod 777 /etc/network/interfaces
sudo echo 'auto wlan0' >> /etc/network/interfaces
sudo echo 'iface wlan0 inet dhcp' >> /etc/network/interfaces
sudo echo 'pre-up sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf' >> /etc/network/interfaces
sudo echo 'post-down killall -q wpa_supplicant' >> /etc/network/interfaces
sudo chmod 644 /etc/network/interfaces
#!/bin/sh
sudo chmod 777 ./rst_nm.sh

echo "Service creation."
if [ ! -f /lib/systemd/system/rst_nm.service ];
then 
    echo "We create a service."
    sudo cp ./rst_nm.service /lib/systemd/system/
else
    echo "Service already created."
fi

echo "Enable service."
sudo systemctl enable rst_nm.service

echo "Let's create a file wpa_suppliant."
if [ ! -f /etc/wpa_supplicant.conf ];
then
    echo "Create wpa_supplicant.conf"
    sudo touch /etc/wpa_supplicant.conf
    sudo chmod 777 /etc/wpa_supplicant.conf
    sudo echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev' >> /etc/wpa_supplicant.conf
    sudo echo 'update_config=1' >> /etc/wpa_supplicant.conf
    sudo chmod 644 /etc/wpa_supplicant.conf
else
    sudo chmod 777 /etc/wpa_supplicant.conf
    sudo echo -n > /etc/wpa_supplicant.conf
    sudo echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev' >> /etc/wpa_supplicant.conf
    sudo echo 'update_config=1' >> /etc/wpa_supplicant.conf
    sudo chmod 644 /etc/wpa_supplicant.conf
fi

echo "Setup interface."
sudo chmod 777 /etc/network/interfaces
echo -n > /etc/network/interfaces
sudo echo 'auto wlan0' >> /etc/network/interfaces
sudo echo 'iface wlan0 inet dhcp' >> /etc/network/interfaces
sudo echo 'pre-up sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf' >> /etc/network/interfaces
sudo echo 'post-down killall -q wpa_supplicant' >> /etc/network/interfaces
sudo chmod 644 /etc/network/interfaces

echo "Done."

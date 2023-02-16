#!/bin/sh

sudo systemctl restart network-manager.service # Reboot service NetworkManager
sudo systemctl stop network-manager.service # Shutdown service NetworkManager

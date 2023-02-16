#!/bin/sh

sudo systemctl restart network-manager.service # Перезагрузка сервиса NetworkManager
sudo systemctl stop network-manager.service # Выключение сервиса NetworkManager
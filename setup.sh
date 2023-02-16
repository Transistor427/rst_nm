#!/bin/sh

# s
sudo cp ./rst_nm.service /lib/systemd/system/

# s
sudo systemctl enable rst_nm.service

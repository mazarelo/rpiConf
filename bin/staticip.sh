#!/bin/bash

echo "****** Assigning Static IP ******"
  sed -n '/nohook lookup-hostname/ i\
          interface eth0
          static ip_address=192.168.0.10/24
          static routers=192.168.0.39
          static domain_name_servers=192.168.0.39

          interface wlan0

          static ip_address=192.168.0.200/24
          static routers=192.168.0.39
          static domain_name_servers=192.168.0.39' 

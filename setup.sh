#!/bin/bash

#Setup to my raspberry pi Servers
PASSWORD='root'
CONFIGFILES=$HOME/.rpiConf
DOWNLOADS=$HOME/Downloads
ROUTERIP = '192.168.0.39'
STATICIP = '192.168.0.200/24'

echo "****** Making files executable ******"
  sudo chmod +==x $CONFIGFILES/*.sh
  sudo chmod +==x $CONFIGFILES/bin/*.sh

#echo "****** Installing Zsh ******"
#sudo apt-get install zsh

echo "****** Installing Git ******"
  sudo apt-get install git

echo "****** Installing Nginx ******"
  sudo apt-get update
  sudo apt-get install nginx -y
echo "****** Adding listener to nginx conf file ******"
  #sed '/http {/ a server {listen 80;listen localhost;location / {root /var/www;}}' nginx.conf

  sed -n '/http {/ i\ 
  http { .*\n/http { server {listen 80;listen localhost;location / {root /var/www;}}' /etc/nginx/nginx.conf

echo "****** Installing PHP Extensions ******"
  apt-get install -y php5-fpm php5-cli php5-mcrypt php5-curl php5-mysql php-apc 

echo "****** Installing Node ******"
  sudo apt-get update
  sudo apt-get install nodejs
  sudo apt-get install npm

echo "****** Starting Nginx ******"
  service nginx start
  update-rc.d nginx defaults

echo "****** Removing Nginx defaults ******"
  sudo rm /etc/nginx/sites-enabled/default
  sudo rm /etc/nginx/sites-available/default

echo "****** Installing Mysq Server ******"
  sudo apt-get install mysql-server

echo "****** Installing phpmyadmin ******"
  sudo apt-get -y install phpmyadmin

echo "****** Enable php extensions ******"
  sudo php5enmod mcrypt

echo "****** Installing Composer ******"
  cd /tmp
  php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  php -r "unlink('composer-setup.php');"

#echo "****** Symlink PhantomJs ******"
  #ln -sf /vagrant/libs/phantomjs /usr/local/bin/phantomjs

echo "****** Restarting Services ******"
  sudo service php5-fpm restart && service nginx restart

echo "****** Installing VNC SERVER ******"
  sudo apt-get upgrade realvnc-vnc-server realvnc-vnc-viewer

#Install No-ip
  #http://www.noip.com/support/knowledgebase/install-ip-duc-onto-raspberry-pi/

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

echo "****** Rebooting Machine ******"
  sudo reboot
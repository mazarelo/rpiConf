#!/bin/bash

#Setup to my raspberry pi Servers

CONFIGFILES=$HOME/.rpiConf
DOWNLOADS=$HOME/Downloads

echo "****** Making files executable ******"
sudo chmod +==x $CONFIGFILES/*.sh

echo "****** Installing Zsh ******"
#sudo apt-get install zsh

echo "****** Installing Git ******"
sudo apt-get install git

echo "****** Installing Nginx ******"
  sudo apt-get update
  sudo apt-get install nginx -y
echo "****** Installing PHP Extensions ******"
apt-get install -y php5-fpm php5-cli php5-mcrypt php5-curl php5-mysql php-apc 

echo "****** Installing Node ******"
  sudo apt-get update
  sudo apt-get install nodejs
  sudo apt-get install npm

echo "****** Restarting Nginx ******"
service nginx start
update-rc.d nginx defaults

echo "****** Removing Nginx defaults ******"
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

echo "****** Installing phpmyadmin ******"
# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
apt-get -y install phpmyadmin

echo "****** Enable php extensions ******"
php5enmod mcrypt

echo "****** Installing Composer ******"
cd /tmp
php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

echo "****** Symlink PhantomJs ******"
#ln -sf /vagrant/libs/phantomjs /usr/local/bin/phantomjs

echo "****** Restarting Services ******"
service php5-fpm restart && service nginx restart

#Install No-ip
#http://www.noip.com/support/knowledgebase/install-ip-duc-onto-raspberry-pi/
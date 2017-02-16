#!/bin/bash

#Setup to my raspberry pi Servers

CONFIGFILES=$HOME/.rpiConf
DOWNLOADS=$HOME/Downloads

#make config files executable
sudo chmod +==x $CONFIGFILES/*.sh

#install zsh
#sudo apt-get install zsh

#install git
sudo apt-get install git

#Install Server

apt-get install -y nginx php5-fpm php5-cli php5-mcrypt php5-curl php5-mysql php-apc node
service nginx start
update-rc.d nginx defaults
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
apt-get -y install phpmyadmin


# Enable php extensions
php5enmod mcrypt

# Install Composer
cd /tmp
php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# Symlink phantomjs
#ln -sf /vagrant/libs/phantomjs /usr/local/bin/phantomjs

service php5-fpm restart && service nginx restart
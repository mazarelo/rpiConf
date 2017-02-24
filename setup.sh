#!/bin/bash

#Setup to my raspberry pi Servers
PASSWORD='root'
CONFIGFILES=$HOME/.rpiConf
DOWNLOADS=$HOME/Downloads
ROUTERIP = '192.168.0.39'
STATICIP = '192.168.0.200/24'

# Include files
source $CONFIGFILES/bin/mysql.sh
source $CONFIGFILES/bin/phpmyadmin.sh
source $CONFIGFILES/bin/oh-my-zsh.sh

echo "****** Making files executable ******"
  sudo chmod +==x $CONFIGFILES/*.sh
  sudo chmod +==x $CONFIGFILES/bin/*.sh

echo "****** Installing Oh-My-Zsh ******"
  powerlinefonts_installer $DOWNLOADS $HOME

echo "****** Installing Git ******"
  sudo apt-get install git

echo "****** Installing Nginx ******"
  $CONFIGFILES/bin/nginx

echo "****** Installing Mysql ******"
  mysql_installer $PASSWORD

echo "****** Installing PHP Extensions ******"
  $CONFIGFILES/bin/phpextensions

echo "****** Installing Node ******"
  $CONFIGFILES/bin/node

echo "****** Installing Mysq Server ******"
  sudo apt-get install mysql-server

echo "****** Installing phpmyadmin ******"
  phpmyadmin_installer $PASSWORD

echo "****** Enable php extensions ******"
  sudo php5enmod mcrypt

echo "****** Installing Composer ******"
  $CONFIGFILES/bin/composer

echo "****** Restarting Services ******"
  sudo service php5-fpm restart && service nginx restart

echo "****** Installing VNC SERVER ******"
  $CONFIGFILES/bin/vncserver

#Install No-ip
  #http://www.noip.com/support/knowledgebase/install-ip-duc-onto-raspberry-pi/

echo "****** Assigning Static IP ******"
  $CONFIGFILES/bin/staticip

echo "****** Rebooting Machine ******"
  sudo reboot
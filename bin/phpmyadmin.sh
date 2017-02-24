#!/bin/bash
phpmyadmin_installer(){
  # for simplicity I'm using the same password for mysql and phpmyadmin
  debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
  debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $1"
  debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $1"
  debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $1"
  debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
  sudo apt-get -y install phpmyadmin
}
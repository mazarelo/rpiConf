#!/bin/bash

#echo "****** Installing Nginx ******"
  sudo apt-get update
  sudo apt-get install nginx -y
echo "****** Adding listener to nginx conf file ******"
  #sed '/http {/ a server {listen 80;listen localhost;location / {root /var/www;}}' nginx.conf

  sed -n '/http {/ i\ 
 	http { .*\n/http { server {listen 80;listen localhost;location / {root /var/www;}}' /etc/nginx/nginx.conf

echo "****** Starting Nginx ******"
  service nginx start
  update-rc.d nginx defaults

echo "****** Removing Nginx defaults ******"
  sudo rm /etc/nginx/sites-enabled/default
  sudo rm /etc/nginx/sites-available/default

  ln -s /etc/nginx/sites-available/*.conf /etc/nginx/sites-enabled
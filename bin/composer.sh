#!/bin/bash
echo "****** Installing Composer ******"
  cd /tmp
  php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  php -r "unlink('composer-setup.php');"
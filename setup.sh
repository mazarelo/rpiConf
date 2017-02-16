#!/bin/bash

#Setup to my raspberry pi Servers

CONFIGFILES=$HOME/.rpiConf
DOWNLOADS=$HOME/Downloads

#make config files executable
sudo chmod +==x $CONFIGFILES/*.sh

#install git
sudo apt-get install git

#install zsh
sudo apt-get install zsh


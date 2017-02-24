
mysql_installer(){
    # install mysql and give password to installer
    sudo apt-get install debconf
    debconf-set-selections <<< "mysql-server mysql-server/root_password password $1"
    debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $1"
    sudo apt-get -y install mysql-server
}

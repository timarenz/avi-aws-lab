#!/bin/sh

echo "mysql-server mysql-server/root_password password avi123!" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password avi123!" | sudo debconf-set-selections
sudo apt-get update
sudo apt-get install -y language-pack-en-base
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
sudo apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install php5.6
sudo apt-get install php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml
sudo service apache2 start
sudo a2dismod php7.0
sudo a2enmod php5.6
sudo service apache2 restart
sudo apt-get install unzip
sudo wget /var/www https://github.com/ethicalhack3r/DVWA/archive/master.zip &
sudo mv master.zip /var/www/
sudo unzip /var/www/master.zip -d /var/www/html/
sudo sed -i 's/p@ssw0rd/avi123!/' /var/www/html/DVWA-master/config/config.inc.php
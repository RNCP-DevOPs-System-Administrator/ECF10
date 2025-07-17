#!/bin/bash

# sudo ip route add default via 192.168.1.1 dev eth1

# Install dependencies
apt update && apt install -y apache2 php gcc make unzip libgd-dev libssl-dev libapache2-mod-php php-gd wget rsyslog

# Create nagios users and groups
useradd nagios
groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagios,nagcmd www-data

# Install Nagios Core
cd /tmp
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.5.9.tar.gz
tar xzf nagios-4.5.9.tar.gz
cd nagios-4.5.9
sudo ./configure --with-command-group=nagcmd --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all
sudo make install-groups-users
sudo make install
sudo make install-init
sudo make install-commandmode
sudo make install-config
sudo make install-webconf

# Create web UI login
sudo htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin

# Enable Apache modules and restart
sudo a2enmod cgi
sudo systemctl restart apache2

# Install Nagios Plugins
cd /tmp
wget https://nagios-plugins.org/download/nagios-plugins-2.4.9.tar.gz
tar xzf nagios-plugins-2.4.9.tar.gz
cd nagios-plugins-2.4.9
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios
sudo make && make install

# Enable Nagios and RSyslog service
sudo apt install -y nagios-nrpe-plugin
sudo systemctl enable rsyslog
sudo systemctl restart rsyslog
sudo systemctl start nagios

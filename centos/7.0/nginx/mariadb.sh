#!/bin/bash

DB_REPO="/etc/yum.repos.d/MariaDB.repo"

# html
cd /usr/share/nginx/html/

#--------------------------------------------------
# Install MariaDB 
#--------------------------------------------------
touch /etc/yum.repos.d/MariaDB.repo
echo "[mariadb]" >> $DB_REPO
echo "name=MariaDB" >> $DB_REPO
echo "baseurl=http://yum.mariadb.org/10.1/centos7-amd64" >> $DB_REPO
echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> $DB_REPO
echo "gpgcheck=1" >> $DB_REPO

# Install MariaDB
echo "\n---- Install MariaDB ----"
sudo yum -y install MariaDB-server MariaDB-client

# Start MariaDB
echo "\n---- Start MariaDB ----"
sudo systemctl start mariadb

# Enable MariaDB On Startup
echo "\n---- Enable MariaDB On Startup ----"
sudo systemctl enable mariadb

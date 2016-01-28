#!/bin/bash

cd /home/centos
curl https://raw.githubusercontent.com/koobitor/nginx_php_script/master/centos/7.0/nginx/setup.sh > setup.sh
chmod +x setup.sh
./setup.sh

cd /home/centos
curl https://raw.githubusercontent.com/koobitor/nginx_php_script/master/centos/7.0/nginx/mariadb.sh > mariadb.sh
chmod +x mariadb.sh
./mariadb.sh

cd /home/centos
curl https://raw.githubusercontent.com/koobitor/nginx_php_script/master/centos/7.0/magento/magento.sh > magento.sh
chmod +x magento.sh
./magento.sh
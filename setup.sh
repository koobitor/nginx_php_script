#!/bin/bash

# Server
OS="centos"
VERSION="7"

# Nginx
NGINX_REPO="/etc/yum.repos.d/nginx.repo"
NGINX_CONF="/etc/nginx/conf.d/default.conf"
FPM_CONF="/etc/php-fpm.d/www.conf"
PHP_CONF="/etc/php.ini"
PHP_INFO="/usr/share/nginx/html/info.php"
NGINX_CONF_REPO="https://raw.githubusercontent.com/koobitor/nginx_conf/master/default.conf"

#--------------------------------------------------
# Update Server
#--------------------------------------------------
sudo yum -y update
sudo yum -y upgrade

#--------------------------------------------------
# Install Nginx 
#--------------------------------------------------
touch /etc/yum.repos.d/nginx.repo
echo "[nginx]" >> $NGINX_REPO
echo "name=nginx repo" >> $NGINX_REPO
echo "baseurl=http://nginx.org/packages/$OS/$VERSION/\$basearch/" >> $NGINX_REPO
echo "gpgcheck=0" >> $NGINX_REPO
echo "enabled=1" >> $NGINX_REPO

# Add Nginx Repository
echo "\n---- Add Nginx Repository ----"
sudo yum -y install epel-release

# Install Nginx
echo "\n---- Install Nginx ----"
sudo yum -y install nginx

# Start Nginx
echo "\n---- Start Nginx ----"
sudo systemctl start nginx

# Enable Nginx On Startup
echo "\n---- Enable Nginx On Startup ----"
sudo systemctl enable nginx

# Set Httpd Connect Network
setsebool -P httpd_can_network_connect=1

#--------------------------------------------------
# Install PHP 
#--------------------------------------------------
echo "\n---- Include the Webtatic EL yum repository data ----"
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

echo "\n---- Install PHP & Dependencies Packages ----"
sudo yum install -y php56w php56w-opcache php56w-xml php56w-mcrypt php56w-gd php56w-devel php56w-mysql php56w-intl php56w-mbstring php56w-fpm

# php version 
php -v

# php.ini
echo "\n---- Configure the PHP Processor ----"
sudo sed -i s/";cgi.fix_pathinfo=1"/"cgi.fix_pathinfo=0"/g $PHP_CONF
sudo sed -i s/"memory_limit = 128M"/"memory_limit = 512M"/g $PHP_CONF

echo "\n---- Configure the php-fpm ----"
sed -i s/"127.0.0.1:9000"/"\/var\/run\/php-fpm\/php-fpm.sock"/g $FPM_CONF
sed -i s/";listen.owner = nobody"/"listen.owner = nginx"/g $FPM_CONF
sed -i s/";listen.group = nobody"/"listen.group = nginx"/g $FPM_CONF
sed -i s/";listen.mode = 0666"/"listen.mode = 0660"/g $FPM_CONF
sed -i s/"user = apache"/"user = nginx"/g $FPM_CONF
sed -i s/"group = apache"/"group = nginx"/g $FPM_CONF

# Start php-fpm
echo "\n---- Start php-fpm ----"
sudo systemctl start php-fpm

# Enable php-fpm On Startup
echo "\n---- Enable php-fpm On Startup ----"
sudo systemctl enable php-fpm

echo "\n---- Configure Nginx ----"
curl $NGINX_CONF_REPO > $NGINX_CONF

echo "\n---- Restart Nginx ----"
sudo systemctl restart nginx

echo "\n---- Touch phpinfo ----"
echo "<?php phpinfo(); ?>" > $PHP_INFO
chown nginx:nginx $PHP_INFO

#--------------------------------------------------
# Install Composer 
#--------------------------------------------------

# Install Composer
echo "\n---- Install Composer ----"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Add Environment Path
echo "\n---- Environment Path ----"
export PATH=$PATH:/usr/local/bin
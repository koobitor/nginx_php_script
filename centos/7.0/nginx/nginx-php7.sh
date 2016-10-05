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
yum -y update
yum -y upgrade

#--------------------------------------------------
# Install Tools 
#--------------------------------------------------
yum -y install wget unzip git
yum -y groupinstall "Development Tools"
yum -y install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel

#--------------------------------------------------
# Install Nginx 
#--------------------------------------------------
# Add Nginx Repository
echo "\n---- Add Nginx Repository ----"
yum -y install epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
rpm -Uvh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

# Install Nginx
echo "\n---- Install Nginx ----"
yum -y install nginx

# Start Nginx
echo "\n---- Start Nginx ----"
systemctl start nginx

# Enable Nginx On Startup
echo "\n---- Enable Nginx On Startup ----"
systemctl enable nginx

# Set Httpd Connect Network
yum -y install policycoreutils
yum -y install /usr/sbin/setsebool
setsebool -P httpd_can_network_connect=1

#--------------------------------------------------
# Install PHP 
#--------------------------------------------------
yum -y install php70w
yum -y install php70w-mysql php70w-xml php70w-soap php70w-xmlrpc
yum -y install php70w-mbstring php70w-json php70w-gd php70w-mcrypt php70w-intl

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

#--------------------------------------------------
# Install PHP FPM
#--------------------------------------------------
yum -y install php70w-fpm

# /var/run/php-fpm/php-fpm.sock
echo "\n---- Configure Nginx ----"
curl $NGINX_CONF_REPO > $NGINX_CONF

echo "\n---- Restart php-fpm ----"
systemctl restart php-fpm

echo "\n---- Restart Nginx ----"
systemctl restart nginx

#!/bin/bash

# 1. https://www.varnish-cache.org/installation/redhat
# 2. http://www.liquidweb.com/kb/how-to-install-varnish-4-on-centos-7/
# 3. http://sharadchhetri.com/2014/12/20/how-to-install-varnish-4-version-on-centos-7-rhel-7/
# 4. https://github.com/PHOENIX-MEDIA/Magento-PageCache-powered-by-Varnish

NGINX_CONF="/etc/nginx/conf.d/default.conf"
VARNISH_PARAMS="/etc/varnish/varnish.params"
VARNISH_VCL="/etc/varnish/default.vcl"

# Step 1
yum install epel-release
rpm --nosignature -i https://repo.varnish-cache.org/redhat/varnish-4.1.el7.rpm 
yum install -y varnish
systemctl enable varnish
systemctl start varnish
varnishd -V

# Step 2
# set port nginx 8080
# /etc/nginx/conf.d/default.conf
sudo sed -i s/"listen      80;"/"listen      8080;"/g $NGINX_CONF

# set port varnish 80
# /etc/varnish/varnish.params
sudo sed -i s/"VARNISH_LISTEN_PORT=6081"/"VARNISH_LISTEN_PORT=80"/g $VARNISH_PARAMS

# set port varnish backend 8080
# /etc/varnish/default.vcl
sudo sed -i s/".port = \"80\";"/".port = \"8080\";"/g $VARNISH_VCL

# Step 3
sudo systemctl restart nginx
systemctl restart varnish
systemctl restart varnishncsa
systemctl restart varnishlog

# Step 4
# cd /usr/share/nginx/
# git clone https://github.com/PHOENIX-MEDIA/Magento-PageCache-powered-by-Varnish.git
# cd Magento-PageCache-powered-by-Varnish/
# cp -Rfn app/* /usr/share/nginx/html/app/
# cd ..
# rm -Rf Magento-PageCache-powered-by-Varnish/
# default_4.1.vcl

# /etc/varnish/varnish.params
# DAEMON_OPTS="-p feature=+esi_disable_xml_check,+esi_ignore_other_elements -p vsl_reclen=4084 -p vcc_allow_inline_c=on"
# systemctl restart varnish
# sudo systemctl restart nginx

#!/bin/bash

cd /usr/share/nginx/html/

#--------------------------------------------------
# Install Magento 
#--------------------------------------------------
wget https://s3-ap-southeast-1.amazonaws.com/topvalley/magento-1.9.2.2.tar.gz
tar -xzvf magento-1.9.2.2.tar.gz
rm -Rf magento-1.9.2.2.tar.gz

#--------------------------------------------------
# Install Magento Simple Data 
#--------------------------------------------------
wget https://s3-ap-southeast-1.amazonaws.com/topvalley/magento-sample-data-1.9.1.0.tar.gz
tar -xvzf magento-sample-data-1.9.1.0.tar.gz
cd magento-sample-data-1.9.1.0
cp -Rn media/ ../
cp -Rn skin/ ../

#--------------------------------------------------
# Create DATABASE 
#--------------------------------------------------
echo "CREATE DATABASE magento;" >> create.sql
mysql -u root < create.sql
mysql -u root magento < magento_sample_data_for_1.9.1.0.sql

#--------------------------------------------------
# Reset File & Folder
#--------------------------------------------------
cd ..
rm -Rf magento-sample-data-1.9.1.0
rm -Rf magento-sample-data-1.9.1.0.tar.gz
chown -Rf nginx:nginx *

#--------------------------------------------------
# Reset Permission
#--------------------------------------------------
chcon -R -t httpd_sys_rw_content_t /usr/share/nginx/html/
chmod 777 -Rf app/etc media/
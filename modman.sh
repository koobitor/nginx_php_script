#!/bin/bash

# https://github.com/colinmollenhour/modman
# https://github.com/colinmollenhour/modman/wiki

# https://firebearstudio.com/blog/how-to-install-magento-extensions-magento-connect-ftp-ssh-modman-composer.html

#--------------------------------------------------
# Install Modman
#--------------------------------------------------
cd /usr/share/nginx/html/
bash < <(curl -s -L https://raw.github.com/colinmollenhour/modman/master/modman-installer)
export PATH=$PATH:/root/bin/

#--------------------------------------------------
# Install Odoo
#--------------------------------------------------
# bzr branch lp:magentoerpconnect/magento-module-oerp6.x-stable magento-module
# cp -Rf magento-module/Openlabs_OpenERPConnector-1.1.0/Openlabs/ app/code/community/
# cp -Rf magento-module/Openlabs_OpenERPConnector-1.1.0/app/etc/modules/Openlabs_OpenERPConnector.xml app/etc/modules/
# rm -Rf magento-module
# chown -Rf centos:nginx *

#--------------------------------------------------
# Fixbug
#--------------------------------------------------
sudo sed -i s/"$this->curlOption(CURLOPT_SSL_CIPHER_LIST, 'TLSv1');"/"$this->curlOption(CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1);"/g /usr/share/nginx/html/downloader/lib/Mage/HTTP/Client/Curl.php

#--------------------------------------------------
# Install Mage
#--------------------------------------------------
echo "\n---- Install Mage ----"
chmod +x mage
./mage mage-setup .
./mage config-set preferred_state stable
./mage channel-add http://connect20.magentocommerce.com/community

#--------------------------------------------------
# Install Extensions
#--------------------------------------------------
echo "\n---- Install Apptrian_Minify_HTML_CSS_JS ----"
./mage install http://connect20.magentocommerce.com/community Easy_Template_Path_Hints
./mage install http://connect20.magentocommerce.com/community Kraken_Image_Optimizer
./mage install http://connect20.magentocommerce.com/community Apptrian_Minify_HTML_CSS_JS
./mage install http://connect20.magentocommerce.com/community ASchroder_SMTPPro
./mage install http://connect20.magentocommerce.com/community Aoe_Scheduler
./mage install http://connect20.magentocommerce.com/community ET_CurrencyManager
./mage install http://connect20.magentocommerce.com/community Bestseller_products
./mage install http://connect20.magentocommerce.com/community Fooman_GoogleAnalyticsPlus

# clear-cache
./mage clear-cache

#--------------------------------------------------
# Sync Custom Extensions
#--------------------------------------------------
cd /usr/share/nginx/
mkdir extensions
cd extensions
aws s3 sync s3://topvalley/extensions/ .

#--------------------------------------------------
# Install Extensions Buyer
#--------------------------------------------------
# mage install-file My_Extension-0.1.0.tgz.

# bubble-highlighter-v1.1.3
mkdir bubble-highlighter-v1.1.3
mv bubble-highlighter-v1.1.3.zip bubble-highlighter-v1.1.3
cd bubble-highlighter-v1.1.3
unzip bubble-highlighter-v1.1.3.zip
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn js/* /usr/share/nginx/html/js/
cd ..
rm -Rf bubble-highlighter-v1.1.3

# social-login-v3.1_magentoce1.4-1.9_2
mkdir social-login-v3.1_magentoce1.4-1.9_2
mv social-login-v3.1_magentoce1.4-1.9_2.zip social-login-v3.1_magentoce1.4-1.9_2
cd social-login-v3.1_magentoce1.4-1.9_2
unzip social-login-v3.1_magentoce1.4-1.9_2.zip
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn js/* /usr/share/nginx/html/js/
cp -Rfn lib/* /usr/share/nginx/html/lib/
cp -Rfn media/* /usr/share/nginx/html/media/
cp -Rfn skin/* /usr/share/nginx/html/skin/
cd ..
rm -Rf social-login-v3.1_magentoce1.4-1.9_2

# webshopapps_premium_rate_7.7.3
mkdir webshopapps_premium_rate_7.7.3
mv webshopapps_premium_rate_7.7.3.zip webshopapps_premium_rate_7.7.3
cd webshopapps_premium_rate_7.7.3
unzip webshopapps_premium_rate_7.7.3.zip
cp -Rfn app/* /usr/share/nginx/html/app/
cd ..
rm -Rf webshopapps_premium_rate_7.7.3

# megamenu_v3.1_magento_community_1.5-1.9
mkdir megamenu_v3.1_magento_community_1.5-1.9
mv megamenu_v3.1_magento_community_1.5-1.9.zip megamenu_v3.1_magento_community_1.5-1.9
cd megamenu_v3.1_magento_community_1.5-1.9
unzip megamenu_v3.1_magento_community_1.5-1.9.zip
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn js/* /usr/share/nginx/html/js/
cp -Rfn media/* /usr/share/nginx/html/media/
cp -Rfn skin/* /usr/share/nginx/html/skin/
cd ..
rm -Rf megamenu_v3.1_magento_community_1.5-1.9

# 1_8_x_bulk_custom_import_products_v42_magento_1_7_x-1_9_x_1
mkdir 1_8_x_bulk_custom_import_products_v42_magento_1_7_x-1_9_x_1
mv 1_8_x_bulk_custom_import_products_v42_magento_1_7_x-1_9_x_1.zip 1_8_x_bulk_custom_import_products_v42_magento_1_7_x-1_9_x_1
cd 1_8_x_bulk_custom_import_products_v42_magento_1_7_x-1_9_x_1
unzip 1_8_x_bulk_custom_import_products_v42_magento_1_7_x-1_9_x_1.zip
cp -Rfn app/* /usr/share/nginx/html/app/
cd ..
rm -Rf 1_8_x_bulk_custom_import_products_v42_magento_1_7_x-1_9_x_1

# bubble-dynamic-category-v2.4.2
mkdir bubble-dynamic-category-v2.4.2
mv bubble-dynamic-category-v2.4.2.zip bubble-dynamic-category-v2.4.2
cd bubble-dynamic-category-v2.4.2
unzip bubble-dynamic-category-v2.4.2.zip
cp -Rfn app/* /usr/share/nginx/html/app/
cd ..
rm -Rf bubble-dynamic-category-v2.4.2

# bubble-elasticsearch-v4.0.0
mkdir bubble-elasticsearch-v4.0.0
mv bubble-elasticsearch-v4.0.0.zip bubble-elasticsearch-v4.0.0
cd bubble-elasticsearch-v4.0.0
unzip bubble-elasticsearch-v4.0.0.zip
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn lib/* /usr/share/nginx/html/lib/
cp -Rfn skin/* /usr/share/nginx/html/skin/
cp -Rfn autocomplete.php /usr/share/nginx/html/
cd ..
rm -Rf bubble-elasticsearch-v4.0.0

# bubble-layer-v2.3.0
mkdir bubble-layer-v2.3.0
mv bubble-layer-v2.3.0.zip bubble-layer-v2.3.0
cd bubble-layer-v2.3.0
unzip bubble-layer-v2.3.0.zip
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn js/* /usr/share/nginx/html/js/
cp -Rfn skin/* /usr/share/nginx/html/skin/
cd ..
rm -Rf bubble-layer-v2.3.0

# bubble-ajax-cart-v1.0.0
mkdir bubble-ajax-cart-v1.0.0
mv bubble-ajax-cart-v1.0.0.zip bubble-ajax-cart-v1.0.0
cd bubble-ajax-cart-v1.0.0
unzip bubble-ajax-cart-v1.0.0.zip
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn skin/* /usr/share/nginx/html/skin/
cd ..
rm -Rf bubble-ajax-cart-v1.0.0

# emipro_order_notification_by_sms_v1.1.0
mkdir emipro_order_notification_by_sms_v1.1.0
mv emipro_order_notification_by_sms_v1.1.0.zip emipro_order_notification_by_sms_v1.1.0
cd emipro_order_notification_by_sms_v1.1.0
unzip emipro_order_notification_by_sms_v1.1.0.zip
cd Emipro\ order\ notification\ by\ sms\ /
cp -Rfn app/* /usr/share/nginx/html/app/
cd ../../
rm -Rf emipro_order_notification_by_sms_v1.1.0

# kasikorn_payment_gateway-1.8.2.zip
mkdir kasikorn_payment_gateway-1.8.2
mv kasikorn_payment_gateway-1.8.2.zip kasikorn_payment_gateway-1.8.2
cd kasikorn_payment_gateway-1.8.2
unzip kasikorn_payment_gateway-1.8.2.zip
cd kasikorn_payment_gateway-1.8.2
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn media/* /usr/share/nginx/html/media/
cd ../../
rm -Rf kasikorn_payment_gateway-1.8.2

# Magento_LinePay-0.7.2.tgz
mkdir Magento_LinePay-0.7.2
mv Magento_LinePay-0.7.2.tgz Magento_LinePay-0.7.2
cd Magento_LinePay-0.7.2
tar -xf Magento_LinePay-0.7.2.tgz
cp -Rfn app/* /usr/share/nginx/html/app/
cd ../
rm -Rf Magento_LinePay-0.7.2

# mirasvit_advanced_seo_suite_1_3_1_1115_topvalue_com
mkdir mirasvit_advanced_seo_suite_1_3_1_1115_topvalue_com
mv mirasvit_advanced_seo_suite_1_3_1_1115_topvalue_com.zip mirasvit_advanced_seo_suite_1_3_1_1115_topvalue_com
cd mirasvit_advanced_seo_suite_1_3_1_1115_topvalue_com
unzip mirasvit_advanced_seo_suite_1_3_1_1115_topvalue_com.zip
cd step1
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn js/* /usr/share/nginx/html/js/
cp -Rfn media/* /usr/share/nginx/html/media/
cp -Rfn shell/* /usr/share/nginx/html/shell/
cp -Rfn skin/* /usr/share/nginx/html/skin/
cd ../
cd step2
cp -Rfn app/* /usr/share/nginx/html/app/
cd ../../
rm -Rf mirasvit_advanced_seo_suite_1_3_1_1115_topvalue_com

# mirasvit_advanced_product_feeds_1_1_2_648_topvalue_com
mkdir mirasvit_advanced_product_feeds_1_1_2_648_topvalue_com
mv mirasvit_advanced_product_feeds_1_1_2_648_topvalue_com.zip mirasvit_advanced_product_feeds_1_1_2_648_topvalue_com
cd mirasvit_advanced_product_feeds_1_1_2_648_topvalue_com
unzip mirasvit_advanced_product_feeds_1_1_2_648_topvalue_com.zip
cd step1
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn js/* /usr/share/nginx/html/js/
cp -Rfn media/* /usr/share/nginx/html/media/
cp -Rfn shell/* /usr/share/nginx/html/shell/
cp -Rfn skin/* /usr/share/nginx/html/skin/
cd ../
cd step2
cp -Rfn app/* /usr/share/nginx/html/app/
cd ../../
rm -Rf mirasvit_advanced_product_feeds_1_1_2_648_topvalue_com

# MOBExtract-For-Odoo-v9.0-Magento-1.9.-.zip
mkdir MOBExtract-For-Odoo-v9.0-Magento-1.9.-
mv MOBExtract-For-Odoo-v9.0-Magento-1.9.-.zip MOBExtract-For-Odoo-v9.0-Magento-1.9.-
cd MOBExtract-For-Odoo-v9.0-Magento-1.9.-
unzip MOBExtract-For-Odoo-v9.0-Magento-1.9.-.zip
cd Magento\ Base\ Module/
cp -Rfn app/* /usr/share/nginx/html/app/
cp -Rfn lib/* /usr/share/nginx/html/lib/
cd ../../
rm -Rf MOBExtract-For-Odoo-v9.0-Magento-1.9.-

# end
cd ..
chown -Rf centos:nginx html
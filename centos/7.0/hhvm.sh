#!/bin/bash

#--------------------------------------------------
# Update Server
#--------------------------------------------------
sudo yum -y update
sudo yum -y upgrade

# EPEL repository
yum -y install epel-release

# 4.8 compiling tools
yum -y install gcc gcc-c++ cpp cmake git psmisc ocaml gperf

# library dependencies
yum -y install binutils-devel boost-devel libmcrypt-devel libmemcached-devel jemalloc-devel libevent-devel sqlite-devel libxslt-devel libicu-devel tbb-devel libzip-devel bzip2-devel openldap-devel readline-devel  elfutils-libelf-devel libdwarf-devel libcap-devel libyaml-devel libedit-devel lz4-devel libvpx-devel unixODBC-devel libgmp-devel libpng-devel ImageMagick-devel curl-devel expat-devel openssl-devel glog-devel oniguruma-devel 

cd /tmp
git clone https://github.com/facebook/hhvm -b master  hhvm  --recursive
cd /tmp/hhvm
./configure
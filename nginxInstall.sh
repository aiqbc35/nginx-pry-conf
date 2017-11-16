#!/bin/bash

yum install make apr* autoconf automake curl curl-devel gcc gcc-c++ zlib-devel openssl openssl-devel pcre-devel gd kernel keyutils patch perl kernel-headers compat*  cpp glibc libgomp libstdc++-devel keyutils-libs-devel libsepol-devel libselinux-devel krb5-devel zlib-devel libXpm* freetype libjpeg* libpng* php-common php-gd ncurses* libtool* libxml2 libxml2-devel patch -y

cd ~

wget  https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz
wget http://nginx.org/download/nginx-1.11.10.tar.gz

mkdir /usr/local/pcre
tar zxvf pcre-8.40.tar.gz
cd pcre-8.40
./configure --prefix=/usr/local/pcre
make
make install

groupadd www
useradd -g www www -s /bin/false
cd ~
tar zxvf nginx-1.11.10.tar.gz
cd nginx-1.11.10
./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_stub_status_module  --with-http_gzip_static_module --with-pcre=~/pcre-8.40
make
make install
/usr/local/nginx/sbin/nginx

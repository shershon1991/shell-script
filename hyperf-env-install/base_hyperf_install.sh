#!/bin/bash
#================================================================
#   Copyright (C) 2020  All rights reserved.
#
#   File：：php_install.sh
#   Author：Wangll
#   Date：2020/08/03
#   Description：install php and swoole
#
#================================================================
work_path="pkg"
php_install_path="/home/work/hyperf/php"
php_name="php-7.2.32.tar.gz"

#swoole_url="https://github.com/swoole/swoole-src/archive/v4.5.2.tar.gz"
#php_download_url="https://www.php.net/distributions/php-7.2.4.tar.gz"
#redis_download_url="http://pecl.php.net/get/redis-5.2.2.tgz"


# install php7.2
install_php(){
  cd $work_path
  mkdir -p /home/work/hyperf/php
      # tar file
      tar zxvf $php_name && cd php-7.2.32
      # install php
      echo "Please hold on! The configure output message is so large so that I hide the output message!..."
      ./configure \
      --prefix=/home/work/hyperf/php \
      --with-config-file-path=/home/work/hyperf/php/etc \
      --with-mysqli=mysqlnd \
      --with-pdo-mysql=mysqlnd \
      --with-openssl \
      --with-curl \
      --with-mhash \
      --with-xmlrpc \
      --without-pear \
      --with-zlib \
      --with-gd \
      --with-iconv \
      --with-jpeg-dir \
      --with-png-dir \
      --with-freetype-dir \
      --with-bz2 \
      --with-gettext \
      --with-libxml-dir \
      --with-fpm-user=work \
      --with-fpm-group=work \
      --enable-fpm \
      --enable-bcmath \
      --enable-mbstring \
      --enable-sockets \
      --enable-xml \
      --enable-zip \
      --enable-soap \
      --enable-ftp \
      --enable-mysqlnd \
      --enable-cgi \
      --enable-session \
      --enable-opcache \
      --enable-cli \
      --enable-sysvmsg \
      --enable-sysvshm \
      --enable-shmop \
      --enable-exif \
      --disable-ipv6

      echo "make and make install"
      make -j 4 && make install
      echo "make success"
      #copy php.ini
      cp php.ini-production /home/work/hyperf/php/etc/php.ini
}

# install swoole
install_swoole(){
  cd ../
  # tar swoole
  tar zxvf swoole-src-4.5.2.tar.gz
  cd swoole-src-4.5.2/
  /home/work/hyperf/php/bin/phpize
  ./configure --with-php-config=/home/work/hyperf/php/bin/php-config
  make clean
  make -j 4 && make install
  echo 'extension=swoole.so' >> /home/work/hyperf/php/etc/php.ini
  echo 'swoole.use_shortname=Off' >> /home/work/hyperf/php/etc/php.ini
  echo "install swoole ext success !"
  /home/work/hyperf/php/bin/php --ri swoole
}

# install  redis
install_redis(){
  cd ../  
  tar zxvf redis-5.2.2.tgz
  cd redis-5.2.2
  make clean
  /home/work/hyperf/php/bin/phpize
  ./configure --with-php-config=/home/work/hyperf/php/bin/php-config
  make -j 4 && make install
  echo "install redis ext success !"
  echo 'extension=redis.so' >> /home/work/hyperf/php/etc/php.ini
  /home/work/hyperf/php/bin/php --ri redis
}

install_supervisor(){
  yum install -y supervisor
  systemctl enable supervisord
  systemctl start supervisord
  systemctl status supervisord
}

install_php
install_swoole
install_redis
install_supervisor

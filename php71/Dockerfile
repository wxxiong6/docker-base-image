#
# Dockerfile for building php-7.1.30 images
# 增加扩展
# xdebug、gd、mongodb、yaf、pdo_mysql、imagick、yar、swoole、xlswriter mcrypt
# see: https://hub.docker.com/_/php
#

FROM php:7.1.30-fpm


ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


LABEL maintainer="wxxiong <wxxiong6@gmail.com>" version="${PHP_VERSION}" description="php-fpm:${PHP_VERSION}"

COPY resources/ /tmp/resources/


#apt-get
RUN  mv /etc/apt/sources.list /etc/apt/sources.list.bak && mv /tmp/resources/sources.list /etc/apt/ \
     && apt-get update -y && apt-get install -y  \
     wget                \
     procps              \
     vim                 \
     inetutils-ping      \
     libssl-dev          \
     libfreetype6        \
     libreadline-dev     \
     libfreetype6-dev   \
     libjpeg62-turbo-dev \
     libmcrypt-dev       \
     libpng-dev          \
     libxml2-dev         \
     libtidy-dev         \
     libxslt1-dev        \
     libcurl4-gnutls-dev \
     \
     && docker-php-ext-configure gd  --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include \
     && docker-php-ext-install  -j$(nproc) gd  pdo_mysql sockets soap bcmath zip \
    \
    && tar -zxf /tmp/resources/xdebug-2.9.4.tgz  -C /tmp/resources/ \
    && cd /tmp/resources/xdebug-2.9.4                \
    && phpize                                   \
    && ./configure --with-php-config=php-config \
    && make -j$(nproc)                          \
    && make install                             \
    \
    && tar -zxf  /tmp/resources/yaf-yaf-3.1.4.tar.gz -C /tmp/resources/ \
    && cd /tmp/resources/yaf-yaf-3.1.4  \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make -j$(nproc) \
    && make install \
    \
    && tar -zxf  /tmp/resources/yar-2.1.2.tgz -C /tmp/resources/ \
    && cd /tmp/resources/yar-2.1.2  \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make -j$(nproc) \
    && make install \
    \
    && tar -zxvf  /tmp/resources/mongodb-1.5.3.tgz -C /tmp/resources/ \
    && cd /tmp/resources/mongodb-1.5.3 \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make  -j$(nproc) \
    && make install \
    \
    && tar -zxvf /tmp/resources/ImageMagick-6.9.10-23.tar.gz -C /tmp/resources/ \
    && cd /tmp/resources/ImageMagick-6.9.10-23 \
    && ./configure \
    && make  -j$(nproc) \
    && make install \
    \
    && tar -zxvf  /tmp/resources/imagick-3.4.3.tgz -C /tmp/resources/ \
    && cd /tmp/resources/imagick-3.4.3 \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make  -j$(nproc) \
    && make install \
    \
    && tar -zxf  /tmp/resources/mcrypt-1.0.2.tgz -C /tmp/resources/ \
    && cd /tmp/resources/mcrypt-1.0.2  \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make -j$(nproc) \
    && make install \
    \
    && tar -zxf  /tmp/resources/swoole-src-4.4.17.tar.gz -C /tmp/resources/ \
    && cd /tmp/resources/swoole-src-4.4.17  \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make -j$(nproc) \
    && make install \
    \
    && tar -zxf  /tmp/resources/xlswriter-1.3.4.tgz -C /tmp/resources/ \
    && cd /tmp/resources/xlswriter-1.3.4 \
    && phpize \
    &&  ./configure --with-php-config=php-config  --enable-reader \
    && make -j$(nproc) \
    && make install \
    \
    && rm -rf /tmp/resources/ \
    && cd ~ \
    \
    && apt-get purge -y --auto-remove \
        -o APT::AutoRemove::RecommendsImportant=false \
        -o APT::AutoRemove::SuggestsImportant=false \
        $buildDeps \
    && rm -rf /var/cache/apt/* \
    && rm -rf /var/lib/apt/lists/*

VOLUME ["/usr/local/etc", "/var/log/php"]
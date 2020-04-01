#
# Dockerfile for building PHP7.2.5 images
# php-ext
# xdebug、gd、mongodb、yaf、pdo_mysql、yar
#
#

FROM php:7.2.5-fpm


ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


LABEL maintainer="wxxiong <wxxiong6@gmail.com>" version="1.0" description="nginx:7.2.5"

#将预先下载好的扩展包从宿主机拷贝进去
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
     && rm -rf /var/cache/apt \
     && docker-php-ext-configure gd  --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include \
     && docker-php-ext-install  -j$(nproc) gd  pdo_mysql sockets soap bcmath zip \
     && docker-php-ext-enable gd  pdo_mysql sockets soap bcmath zip               \
    \
    && tar -zxf /tmp/resources/xdebug-2.6.1.tgz  -C /tmp/resources/ \
    && cd /tmp/resources/xdebug-2.6.1                     \
    && phpize                                   \
    && ./configure --with-php-config=php-config \
    && make -j$(nproc)                          \
    && make install                             \
    \
    && tar -zxf  /tmp/resources/yaf-3.0.7.tgz -C /tmp/resources/ \
    && cd /tmp/resources/yaf-3.0.7  \
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
    && tar -zxf  /tmp/resources/yar-2.0.5.tgz -C /tmp/resources/ \
    && cd /tmp/resources/yar-2.0.5  \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make -j$(nproc) \
    && make install \
    \
    && tar -zxf  /tmp/resources/mcrypt-1.0.2.tgz -C /tmp/resources/ \
    && cd /tmp/resources/mcrypt-1.0.2  \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make -j$(nproc) \
    && make install \
    \
    && cp /tmp/resources/php7/etc/php/php.ini  /usr/local/etc/php/ \
    && cp /tmp/resources/php7/etc/php/conf.d/* /usr/local/etc/php/conf.d/ \
    && rm -rvf /tmp/resources/

VOLUME ["/usr/local/etc", "/var/log/php"]
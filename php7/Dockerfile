#
# Dockerfile for building PHP7 images
# php-ext
# xdebug、gd、mongodb、yaf、pdo_mysql
#
#

FROM php:7.2.5-fpm
MAINTAINER wxxiong <wxxiong6@gmail.com>

ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

LABEL version="1.0"
LABEL description="php-fpm:7.2.5"

#apt-get
RUN apt-get install -y \
     wget \
     inetutils-ping \
     libfreetype6-dev \
     libjpeg62-turbo-dev \
     libmcrypt-dev \
     libpng-dev \
     libxml2-dev \
     libtidy-dev \
     libxslt1-dev \
     \
     && rm -rf /var/cache/apt \
     && docker-php-ext-configure gd  --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include \
     && docker-php-ext-install  -j$(nproc) gd  pdo_mysql sockets soap\
     && docker-php-ext-enable gd  pdo_mysql sockets soap




#将预先下载好的拓展包从宿主机拷贝进去
COPY resources/xdebug-2.6.1.tgz /tmp/
COPY resources/yaf-3.0.7.tgz /tmp/
COPY resources/mongodb-1.5.3.tgz /tmp/
COPY resources/ImageMagick-6.9.10-23.tar.gz /tmp/
COPY resources/imagick-3.4.3.tgz /tmp/


RUN tar -zxf /tmp/xdebug-2.6.1.tgz  -C /tmp/ \
    && cd /tmp/xdebug-2.6.1 \
    && phpize \
    && ./configure --with-php-config=php-config \
    && make -j$(nproc) \
    && make install     \
    && rm -rf /tmp/xdebug-2.6.1  /tmp/xdebug-2.6.1.tgz \
    \
    && tar -zxf  /tmp/yaf-3.0.7.tgz -C /tmp/ \
    && cd /tmp/yaf-3.0.7  \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/yaf-3.0.7 /tmp/yaf-3.0.7.tgz \
    \
    && tar -zxvf  /tmp/mongodb-1.5.3.tgz -C /tmp/ \
    && cd /tmp/mongodb-1.5.3 \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make  -j$(nproc) \
    && make install \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini \
    && rm -rf /tmp/mongodb-1.5.3  /tmp/mongodb-1.5.3.tgz \
    \
    && tar -zxvf ImageMagick-6.9.10-23.tar.gz -C /tmp/ \
    && cd /tmp/ImageMagick-6.9.10-23 \
    && ./configure \
    && make  -j$(nproc) \
    && make install \
    && rm -rf /tmp/ImageMagick-6.9.10-23  /tmp/ImageMagick-6.9.10-23.tar.gz \
    \
    && tar -zxvf  /tmp/imagick-3.4.3.tgz -C /tmp/ \
    && cd /tmp/imagick-3.4.3 \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make  -j$(nproc) \
    && make install \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini \
    && rm -rf /tmp/imagick-3.4.3  /tmp/imagick-3.4.3.tgz

COPY resources/php7/etc/php/php.ini  /usr/local/etc/php/
COPY resources/php7/etc/php/conf.d/php-ext-xdebug.ini /usr/local/etc/php/conf.d
COPY resources/php7/etc/php/conf.d/php-ext-yaf.ini /usr/local/etc/php/conf.d






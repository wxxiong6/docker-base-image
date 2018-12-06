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


#apt-get
RUN apt-get update && apt-get install -y \
     wget \
     inetutils-ping \
     libfreetype6-dev \
     libjpeg62-turbo-dev \
     libmcrypt-dev \
     libpng-dev

RUN docker-php-ext-configure gd  --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include \
    && docker-php-ext-install  -j$(nproc) gd  pdo_mysql \
    && docker-php-ext-enable gd  pdo_mysql



#将预先下载好的拓展包从宿主机拷贝进去
COPY resources/xdebug-2.6.1.tgz /tmp/
COPY resources/yaf-3.0.7.tgz /tmp/
COPY resources/mongodb-1.5.3.tgz /tmp/


RUN tar -zxvf /tmp/xdebug-2.6.1.tgz  -C /tmp/ \
    && tar -zxvf  /tmp/yaf-3.0.7.tgz -C /tmp/ \
    && tar -zxvf  /tmp/mongodb-1.5.3.tgz -C /tmp/

RUN cd /tmp/xdebug-2.6.1 \
     && phpize \
     && ./configure --with-php-config=php-config \
     && make -j$(nproc) \
     && make install


RUN cd /tmp/yaf-3.0.7  \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make -j$(nproc) \
    && make install


RUN cd /tmp/mongodb-1.5.3 \
    && phpize \
    &&  ./configure --with-php-config=php-config \
    && make  -j$(nproc) \
    && make install \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini



COPY resources/php7/etc/php/php.ini  /usr/local/etc/php/
COPY resources/php7/etc/php/conf.d/php-ext-xdebug.ini /usr/local/etc/php/conf.d
COPY resources/php7/etc/php/conf.d/php-ext-yaf.ini /usr/local/etc/php/conf.d


RUN rm -rf /tmp/yaf-3.0.7 \
        && rm -rf /tmp/xdebug-2.6.1  \
        && rm -rf  /tmp/mongodb-1.5.3 \
        && rm -rf /tmp/xdebug-2.6.1.tgz \
        && rm -rf /tmp/yaf-3.0.7.tgz \
        && rm -rf /tmp/mongodb-1.5.3.tgz




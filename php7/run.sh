#!/bin/bash



nginx_web_dir="/var/www/html"
docker_php_dir="/docker/php7/"
docker_name="xwx/php-fpm:7.2.5"

if [ ! -d $nginx_web_dir ]; then
	echo "mkdir -p $nginx_web_dir"
	mkdir -p $nginx_web_dir	
fi

if [ ! -d $docker_php_dir ]; then
	echo "mkdir -p $docker_php_dir"
	mkdir -p $docker_php_dir
fi


docker run -p 9000:9000 --name  php-fpm  -v ${nginx_web_dir}:/var/www/html -v ${docker_php_dir}/etc:/usr/local/etc  -d ${docker_name}



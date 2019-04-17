#!/bin/bash

nginx_web_dir="/var/www/html"
docker_nginx_dir="/docker/nginx/"
docker_name="xwx/nginx:1.10"

if [ ! -d $nginx_web_dir ]; then
	echo "mkdir -p $nginx_web_dir"
	mkdir -p $nginx_web_dir	
fi

if [ ! -d $docker_nginx_dir ]; then
	echo "mkdir -p $docker_php_dir"
	mkdir -p $docker_nginx_dir
fi


docker run --name nginx  --link php-fpm:php-fpm -p 80:80 -p443:443 -v ${nginx_web_dir}:/var/www/html -v ${nginx_home_dir}/conf/nginx.conf:/etc/nginx/nginx.conf -v  ${nginx_home_dir}/conf/conf.d:/etc/nginx/conf.d -v ${nginx_home_dir}/logs:/var/log/nginx -d ${docker_name}


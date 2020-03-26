#!/bin/bash 

nginx_web_dir="${HOME}/var/www/html"
docker_php_dir="${HOME}/docker/php7.2"
docker_name="wxxiong6/php-fpm:7.2.5"

if [ ! -d $nginx_web_dir ]; then
	echo "mkdir -p $nginx_web_dir"
	mkdir -p $nginx_web_dir	
fi

if [ ! -d $docker_php_dir ]; then
	echo "mkdir -p $docker_php_dir"
	mkdir -p $docker_php_dir
fi

cp -rf ./resources/php7/etc/* ${docker_php_dir}/etc/

old_docker_name=`docker ps -a|grep php-fpm|awk '{print $1}'`
if [ -n "$old_docker_name" ]; then
    rm_res=`docker stop ${old_docker_name} && docker rm ${old_docker_name}`
    echo "删除之前安装php-fpm容器:${old_docker_name},${rm_res}"
fi
res=`docker run -p 9000:9000 --name  php-fpm  -v ${nginx_web_dir}:/var/www/html -v ${docker_php_dir}/php7.2/logs:/var/log/php  -v ${docker_php_dir}/etc:/usr/local/etc  -d ${docker_name}`
if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi


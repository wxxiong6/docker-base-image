#!/bin/bash

nginx_web_dir="/var/www/html"
docker_nginx_dir="/docker/nginx/"
docker_name="xwx/nginx:1.10"
docker_nginx_conf_dir=${nginx_home_dir}/conf

if [ ! -d $nginx_web_dir ]; then
	echo "mkdir -p $nginx_web_dir"
	mkdir -p $nginx_web_dir	
fi

if [ ! -d $docker_nginx_dir ]; then
	echo "mkdir -p $docker_php_dir"
	mkdir -p $docker_nginx_dir
fi

if [ !-d $docker_nginx_conf_dir ]; then
	echo "mkdir -p $docker_nginx_conf_dir"
	mkdir -p $docker_nginx_conf_dir
fi

cp -rf ./resources/conf/* ${docker_php_dir}/conf/

old_docker_name=`docker ps -a|grep nginx|awk '{print $1}'`
if [ -n "$old_docker_name" ]; then
    rm_res=`docker stop ${old_docker_name} && docker rm ${old_docker_name}`
    echo "删除之前安装php-fpm容器:${old_docker_name},${rm_res}"
fi
res=`docker run --name nginx  --link php-fpm:php-fpm -p 80:80 -p443:443 -v ${nginx_web_dir}:/var/www/html -v ${nginx_home_dir}/conf/nginx.conf:/etc/nginx/nginx.conf -v  ${nginx_home_dir}/conf/conf.d:/etc/nginx/conf.d -v ${nginx_home_dir}/logs:/var/log/nginx -d ${docker_name}`
if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi
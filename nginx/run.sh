#!/bin/bash

file=".env"

if [ -f "$file" ]
then
  echo "$file found."

  while IFS='=' read -r key value
  do
	echo "${key}=${value}"
  
  done < "$file"

else
  echo "$file not found."
fi



old_docker_name=`docker ps -a|grep nginx|awk '{print $1}'`
if [ -n "$old_docker_name" ]; then
    rm_res=`docker stop ${old_docker_name} && docker rm ${old_docker_name}`
    echo "删除之前安装php-fpm容器:${old_docker_name},${rm_res}"
fi
res=`docker run --name nginx  --link php-fpm:php-fpm -p 80:80 -p 443:443 -v ${nginx_web_dir}:/var/www/html -v ${docker_nginx_dir}/nginx.conf:/etc/nginx/nginx.conf -v ${docker_nginx_dir}/conf.d:/etc/nginx/conf.d -v ${docker_nginx_dir}/logs:/var/log/nginx -d ${docker_name}`
if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi
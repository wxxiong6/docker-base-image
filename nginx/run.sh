#!/bin/bash
path=$(dirname "$PWD")
file=$path"/.env"

if [ -f "$file" ]
then
  echo "$file found."

  while IFS='=' read -r key value
  do
#	echo ${key}=${value/\~/~}
  export ${key}=${value/\~/~}
  done < "$file"
 
else
  echo "$file not found."
fi
#echo set
#echo ${WEBROOT_DIR}
#echo ${DOCKERFILE_DIR}
#echo ${DOCKE_LOGS_DIR}
#echo ${DOCKER_DATA_DIR}




old_docker_name=`docker ps -a|grep nginx|awk '{print $1}'`
if [ -n "$old_docker_name" ]; then
    rm_res=`docker stop ${old_docker_name} && docker rm ${old_docker_name}`
    echo "删除之前安装nginx:${old_docker_name},${rm_res}"
fi
res=`docker run --name nginx  --link php-fpm:php-fpm -p 80:80 -p 443:443 -v ${WEBROOT_DIR}:/var/www/html -v ${DOCKERFILE_DIR}/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v ${DOCKERFILE_DIR}/nginx/conf/conf.d:/etc/nginx/conf.d -v ${DOCKER_LOGS_DIR}${DOCKER_LOGS_DIR}/nginx:/var/log/nginx -d "${DOCKER_USER}/nginx:1.11"`
if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi
#!/bin/bash 

path=$(dirname "$PWD")
file=$path"/.env"

if [ -f "$file" ]; then
    echo "$file found."

    while IFS='=' read -r key value
    do
#	echo ${key}=${value/\~/~}
    export ${key}=${value/\~/~}
    done < "$file"
 
else
    echo "$file not found."
fi

#echo ${WEBROOT_DIR}
#echo ${DOCKERFILE_DIR}
#echo ${DOCKE_LOGS_DIR}
#echo ${DOCKER_DATA_DIR}


old_docker_name=`docker ps -a|grep php-fpm|awk '{print $1}'`
if [ -n "$old_docker_name" ]; then
    rm_res=`docker stop ${old_docker_name} && docker rm ${old_docker_name}`
    echo "删除之前安装php-fpm容器:${old_docker_name},${rm_res}"
fi
res=`docker run -p 9000:9000 --name  php-fpm  -v ${WEBROOT_DIR}:/var/www/html -v ${DOCKER_LOGS_DIR}/php${PHP_VERSION}:/var/log/php  -v ${DOCKERFILE_DIR}/php72/etc:/usr/local/etc  -d "${DOCKER_USER}/php-fpm:7.2.5"`
if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi


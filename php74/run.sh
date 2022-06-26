#!/bin/bash 
#set -x
path=$(dirname "$PWD")
file=$path"/.env"

if [ -f "$file" ]; then
    
    while IFS='=' read -r key value
    do
#	echo ${key}=${value/\~/~}
    export ${key}=${value/\~/~}
    done < "$file"
 
else
    echo "$file not found."
    exit -1;
fi

#echo ${WEBROOT_DIR}
#echo ${DOCKERFILE_DIR}
#echo ${DOCKE_LOGS_DIR}
#echo ${DOCKER_DATA_DIR}
#echo ${PHP_VERSION}

old_docker_name=$(docker ps -a|grep php-fpm|awk '{print $1}')
if [ -n "$old_docker_name" ]; then
    rm_res=$(docker stop ${old_docker_name} && docker rm ${old_docker_name})
    echo "del older php-fpm containt:${old_docker_name},${rm_res}"
fi
res=$(docker run -p 9000:9000 --name  php-fpm  -v ${WEBROOT_DIR}:/var/www/html -v ${DOCKER_LOGS_DIR}/php${PHP_VERSION}:/var/log/php  -v ${DOCKERFILE_DIR}/php${PHP_VERSION}/etc:/usr/local/etc  -d "${DOCKER_USER}/php-fpm:${PHP_VERSION}")
if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi


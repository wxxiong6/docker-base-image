#!/bin/bash 





old_docker_name=`docker ps -a|grep php-fpm|awk '{print $1}'`
if [ -n "$old_docker_name" ]; then
    rm_res=`docker stop ${old_docker_name} && docker rm ${old_docker_name}`
    echo "删除之前安装php-fpm容器:${old_docker_name},${rm_res}"
fi
res=`docker run -p 9000:9000 --name  php-fpm  -v ${WEBROOT_DIR}:/var/www/html -v ${DOCKER_LOGS_DIR}/php7.2:/var/log/php  -v ${DOCKER_FILE_DIR}/php7.2/etc:/usr/local/etc  -d ${DOCKER_USER}/php-fpm`
if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi


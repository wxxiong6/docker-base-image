#!/bin/bash
set -x

docker_mysql_dir=$(dirname $(dirname $(pwd)))/mysql80
docker_name="mysql"
label="8.0"


if [ ! -d $docker_mysql_dir ]; then
	echo "mkdir -p $docker_mysql_dir"
	mkdir -p $docker_mysql_dir
fi


last_docke_name=$(docker ps -a|grep ${docker_name}|awk '{print $1}')
if [ -n "$last_docke_name" ]; then
    $(docker stop ${last_docke_name} && docker rm ${last_docke_name})
    echo "delete old container: '${last_docke_name}'"
fi
	   
res=$(docker run -p 3306:3306                      \
	--name mysql                                   \
	-v ${docker_mysql_dir}/conf:/etc/mysql/conf.d  \
	-v ${docker_mysql_dir}/logs:/logs              \
	-v ${docker_mysql_dir}/data:/var/lib/mysql     \
	-e TZ=Asia/Shanghai                            \
	-e MYSQL_ROOT_PASSWORD=root                    \
	-d ${docker_name}:${label}                              \
	--default-authentication-plugin=mysql_native_password)    

if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi

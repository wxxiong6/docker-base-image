#!/bin/bash
set -x

docker_mysql_dir=$(dirname $(dirname $(pwd)))/mysql80
docker_name="mysql:8.0"


if [ ! -d $docker_mysql_dir ]; then
	echo "mkdir -p $docker_mysql_dir"
	mkdir -p $docker_mysql_dir
fi





old_docker_name=`docker ps -a|grep mysql|awk '{print $1}'`
if [ -n "$old_docker_name" ]; then
    rm_res=`docker stop ${old_docker_name} && docker rm ${old_docker_name}`
    echo "删除之前安装容器:'${old_docker_name}',${rm_res}"
fi

res=`docker run -p 3306:3306 --name mysql -v ${docker_mysql_dir}/conf:/etc/mysql/conf.d -v ${docker_mysql_dir}/logs:/logs -v ${docker_mysql_dir}/data:/var/lib/mysql -e TZ=Asia/Shanghai -e MYSQL_ROOT_PASSWORD=root -d ${docker_name}`

if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi

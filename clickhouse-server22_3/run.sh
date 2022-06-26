#!/bin/bash 
#set -ex

path=$(dirname "$PWD")
file=$path"/.env"

if [ -f "$file" ]; then
    echo "$file found."

    while IFS='=' read -r key value
    do
    export ${key}=${value/\~/~}
    done < "$file"
 
else
    echo "$file not found."
fi

docker_clickhouse_dir=$(dirname $(dirname $(pwd)))/data/clickhous22
docker_name="clickhouse-server:22.3.7.28"


if [ ! -d $docker_clickhouse_dir ]; then
	echo "mkdir -p $docker_clickhouse_dir"
	mkdir -p $docker_clickhouse_dir
fi


old_docker_name=`docker ps -a|grep clickhouse|awk '{print $1}'`
if [ -n "$old_docker_name" ]; then
    rm_res=`docker stop ${old_docker_name} && docker rm ${old_docker_name}`
    echo "delete the previous  container: '${old_docker_name}'"
fi
	   

docker run  -d    --name=clickhouse-server \
	-p 9000:9000  \
	-v ${docker_clickhouse_dir}/ch_data:/var/lib/clickhouse/ \
	-v ${docker_clickhouse_dir}/ch_logs:/var/log/clickhouse-server/ \
    --ulimit nofile=262144:262144  \
   clickhouse/clickhouse-server:22.3.7.28    
    #-v ${path}/etc/config.d/config.xml:/etc/clickhouse-server/config.xml \
    ###-v ${path}/etc/config.d/config.xml:/etc/clickhouse-server/config.xml \
   # -e CLICKHOUSE_DB=my_database                      \
#	-e CLICKHOUSE_USER=username                        \
#	-e CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=1        \
#	-e CLICKHOUSE_PASSWORD=password                   \

if [ $? -eq 0 ]; then
    echo "install success"
else
    echo "install failure"
fi


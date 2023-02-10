#!/bin/bash
set -x

docker_postgressql_dir=$(dirname $(dirname $(pwd)))/postgres96
docker_name="postgres"
label="9.6"


if [ ! -d $docker_postgressql_dir ]; then
	echo "mkdir -p $docker_postgressql_dir"
	mkdir -p $docker_postgressql_dir
fi


last_docke_name=$(docker ps -a|grep ${docker_name}|awk '{print $1}')
if [ -n "$last_docke_name" ]; then
    $(docker stop ${last_docke_name} && docker rm ${last_docke_name})
    echo "delete old container: '${last_docke_name}'"
fi
	   
res=$(docker run -p 5432:5432                               \
	--name postgressql                                   \
	-v ${docker_postgressql_dir}/data:/var/lib/postgressql/data    \
	-e POSTGRES_PASSWORD=password               \
	-d ${docker_name}:${label})                              

if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi

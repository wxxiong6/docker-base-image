#/bin/bash


docker_redis_dir="/docker/redis/"
docker_name="redis:3.2"


if [ ! -d $docker_redis_dir ]; then
	echo "mkdir -p $docker_redis_dir"
	mkdir -p $nginx_web_dir	
fi


docker run --name redis -p 6379:6379 -v ${docker_redis_dir}/data:/data  -d ${docker_name}  redis-server --appendonly yes 

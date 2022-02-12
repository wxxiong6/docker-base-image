#/bin/bash


docker_redis_dir="/docker/redis/"
docker_name="redis:5.0"


if [ ! -d $docker_redis_dir ]; then
	echo "mkdir -p $docker_redis_dir"
	mkdir -p $nginx_web_dir	
fi

old_docker_name=`docker ps -a|grep redis-server|awk '{print $1}'`
if [ -n "$old_docker_name" ]; then
    rm_res=`docker stop ${old_docker_name} && docker rm ${old_docker_name}`
    echo "删除之前安装redis-server容器:${old_docker_name},${rm_res}"
fi

res=`docker run --name redis-server -p 6379:6379 -v ${docker_redis_dir}/data:/data -v ${docker_redis_dir}/conf:/etc/redis/  -d ${docker_name}  redis-server --appendonly yes` 
if [ -n "$res" ]; then
    echo "install success [$res]"
else
    echo "install failure"
fi


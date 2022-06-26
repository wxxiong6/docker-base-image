#!/bin/bash
######构建nginx镜像

docker_name="wxxiong6/nginx:1.21.6-alpine"
docker build . -t ${docker_name}

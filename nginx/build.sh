#!/bin/bash
######构建nginx镜像

docker_name="xwx/nginx:1.10"
docker build . -t ${docker_name}
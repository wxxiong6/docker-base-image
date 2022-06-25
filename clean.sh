#!/bin/bash

#REM 删除全部容器
#docker rm $(docker ps -a -q)
#REM 删除全部镜像
#docker rmi $(docker images -q)
#REM 删除没用的镜像（none）
docker rmi $(docker images --filter dangling=true -q --no-trunc)

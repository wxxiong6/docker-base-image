#!/bin/bash
###### build nodejs image

docker_name="wxxiong6/node:14-alpine"
docker build . -t ${docker_name}

#!/bin/bash
###### build nodejs image

docker_name="wxxiong6/node:16-alpine"
docker build . -t ${docker_name}

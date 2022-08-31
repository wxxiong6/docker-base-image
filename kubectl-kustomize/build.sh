#!/bin/bash
###### build  kubectl-kustomize image

docker_name="wxxiong6/kubectl-kustomize:1.25.0-4.5.7"
docker build . -t ${docker_name}

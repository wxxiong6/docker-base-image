#!/bin/bash
#mail: wxxiong6@gmail.com

path=$(dirname "$PWD")
file=$path"/.env"

if [ -f "$file" ]
then
    echo "$file found."

    while IFS='=' read -r key value
    do
#	echo ${key}=${value/\~/~}
    export ${key}=${value/\~/~}
    done < "$file"
 
else
    echo "$file not found."
fi
docker build . -t ${DOCKER_USER}/php:${PHP_VERSION}
